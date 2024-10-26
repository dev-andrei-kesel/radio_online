import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

import '../common/string_resources.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  Stream<String> get errorMessageStream => _errorMessageStreamController.stream;
  final _errorMessageStreamController = StreamController<String>();

  Stream<String> get checkUrlStream => _checkUrlController.stream;
  final _checkUrlController = StreamController<String>.broadcast();

  RadioStationEntity? station;

  AudioPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    await (await AudioSession.instance)
        .configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _player.playerStateStream.listen(
      (playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          stop();
        }
      },
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    try {
      await _setAudioSource(mediaItem);
    } catch (e) {
      _checkUrlController.add('');
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
    return super.onTaskRemoved();
  }

  Future<void> setRadioStation(RadioStationEntity? station) async {
    try {
      this.station = station;
      playMediaItem(
        MediaItem(
          id: station?.url ?? '',
          title: station?.name ?? '',
          displayTitle: station?.country ?? '',
          displaySubtitle: station?.name ?? '',
          artUri: Uri.parse(station?.favicon.toString().isNotEmpty == true
              ? station?.favicon ?? StringResources.imageUrl
              : StringResources.imageUrl),
          duration: const Duration(hours: 24, minutes: 00, seconds: 00),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> closeSnackBar() async {
    _errorMessageStreamController.add('');
  }

  Future<void> _setAudioSource(MediaItem mediaItem) async {
    if (_player.playing) {
      _player.stop();
    }
    if (await _checkUrl(mediaItem.id)) {
      this.mediaItem.add(mediaItem);
      _checkUrlController.add('');
      _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)),
          initialIndex: 0, initialPosition: Duration.zero);
      _player.play();
    } else {
      _checkUrlController.add('');
      _errorMessageStreamController.add(StringResources.errorMessageStream);
    }
  }

  Future<bool> _checkUrl(String url) async {
    _checkUrlController.add(url);
    try {
      final player = AudioPlayer();
      await player.setAudioSource(AudioSource.uri(Uri.parse(url)),
          initialIndex: 0, initialPosition: Duration.zero);
      await player.dispose();
      return true;
    } on Exception {
      _checkUrlController.add('');
      return false;
    }
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop
      ],
      systemActions: const {
        MediaAction.pause,
        MediaAction.play,
        MediaAction.stop
      },
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      bufferedPosition: _player.bufferedPosition,
      updatePosition: _player.position,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  Future<void> requestNotificationPermission() async {
    if (!kIsWeb) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.notification, Permission.bluetooth].request();
      statuses.forEach(
        (permission, status) {
          if (status.isGranted) {
          } else if (status.isDenied) {
          } else if (status.isPermanentlyDenied) {
            openAppSettings();
          }
        },
      );
    }
  }

  Future<void> dispose() async {
    _player.dispose();
    _errorMessageStreamController.close();
    _checkUrlController.close();
    await stop();
  }
}
