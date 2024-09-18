import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    if (_player.playing) {
      _player.stop();
      this.mediaItem.add(mediaItem);
      _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)),
          initialIndex: 0, initialPosition: Duration.zero);
      _player.play();
    } else {
      _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
      this.mediaItem.add(mediaItem);
      _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)),
          initialIndex: 0, initialPosition: Duration.zero);
      _player.play();
    }
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        if (_player.playing) MediaControl.pause else MediaControl.play,
      ],
      systemActions: const {
        MediaAction.skipToPrevious,
        MediaAction.play,
        MediaAction.pause,
        MediaAction.stop,
        MediaAction.skipToNext,
      },
      androidCompactActionIndices: const [0, 1,3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
