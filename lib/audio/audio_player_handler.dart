import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();
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
    if (_player.playing) {
      _player.stop();
      this.mediaItem.add(mediaItem);
      _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)),
          initialIndex: 0, initialPosition: Duration.zero);
      _player.play();
    } else {
      this.mediaItem.add(mediaItem);
      _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)),
          initialIndex: 0, initialPosition: Duration.zero);
      _player.play();
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
    return super.onTaskRemoved();
  }

  Future<void> setRadioStation(RadioStationEntity? station) async {
    this.station = station;
    playMediaItem(
      MediaItem(
        id: station?.url ?? '',
        title: station?.name ?? '',
        displayTitle: station?.country ?? '',
        displaySubtitle: station?.name ?? '',
        artUri: Uri.parse(station?.favicon ?? ''),
        duration: const Duration(hours: 24, minutes: 00, seconds: 00),
      ),
    );
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
    var status = await Permission.notification.request();
    if (status.isGranted) {
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
