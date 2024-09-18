import 'package:audio_service/audio_service.dart';

class AudioState {
  final MediaItem? mediaItem;
  final Duration position;

  AudioState(this.mediaItem, this.position);
}