import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';

class RadioPlayerWidget extends StatelessWidget {
  final AudioHandler? audioHandler;

  const RadioPlayerWidget({super.key, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.selected.withOpacity(0.15),
        border: Border.all(color: context.colors.unselected),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: StreamBuilder<MediaItem?>(
        stream: audioHandler?.mediaItem,
        builder: (context, snapshot) {
          final mediaItem = snapshot.data;
          if (mediaItem == null) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<PlaybackState>(
                  stream: audioHandler?.playbackState ??
                      Stream.value(PlaybackState()),
                  builder: (context, snapshot) {
                    final playbackState = snapshot.data;
                    if (playbackState?.processingState.name ==
                        ProcessingState.loading.name) {
                      return CircularProgressIndicator(
                        color: context.colors.text,
                      );
                    } else {
                      return CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            NetworkImage(mediaItem.artUri.toString()),
                      );
                    }
                  },
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        mediaItem.title.toString(),
                        textAlign: TextAlign.center,
                        style: context.styles.header,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        mediaItem.displaySubtitle.toString(),
                        textAlign: TextAlign.center,
                        style: context.styles.header,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => audioHandler?.stop(),
                      icon: Icon(color: context.colors.selected, Icons.stop),
                    ),
                    StreamBuilder<bool>(
                      stream: audioHandler?.playbackState
                              .map((state) => state.playing)
                              .distinct() ??
                          Stream.value(false),
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data;
                        return isPlaying == true
                            ? IconButton(
                                onPressed: () {
                                  audioHandler?.pause();
                                },
                                icon: Icon(
                                    color: context.colors.selected,
                                    Icons.pause),
                              )
                            : IconButton(
                                onPressed: () {
                                  audioHandler?.play();
                                },
                                icon: Icon(
                                  color: context.colors.selected,
                                  Icons.play_arrow,
                                ),
                              );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        color: mediaItem.extras?['isLike']
                            ? Colors.red
                            : Colors.white,
                        Icons.favorite,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

//   Center(
//   child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   // Show media item title
//
//   // Play/pause/stop buttons.
//   StreamBuilder<bool>(
//   stream: audioHandler?.playbackState
//       .map((state) => state.playing)
//       .distinct(),
//   builder: (context, snapshot) {
//   final playing = snapshot.data ?? false;
//   return Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   _button(Icons.fast_rewind, audioHandler.rewind),
//   if (playing)
//   _button(Icons.pause, audioHandler.pause)
//   else
//   _button(Icons.play_arrow, audioHandler.play),
//   _button(Icons.stop, audioHandler.stop),
//   _button(Icons.fast_forward, audioHandler.fastForward),
//   ],
//   );
//   },
//   ),
//   // A seek bar.

//   //   },
//   // ),
//   // Display the processing state.
//   StreamBuilder<AudioProcessingState>(
//   stream: audioHandler.playbackState
//       .map((state) => state.processingState)
//       .distinct(),
//   builder: (context, snapshot) {
//   final processingState =
//   snapshot.data ?? AudioProcessingState.idle;
//   return Text(
//   // ignore: deprecated_member_use
//   "Processing state: ${describeEnum(processingState)}");
//   },
//   ),
//   ],
//   ),
//   );
// }
//
// /// A stream reporting the combined state of the current media item and its
// /// current position.
// Stream<AudioState> get _mediaStateStream =>
//     Rx.combineLatest2<MediaItem?, Duration, AudioState>(
//         audioHandler.mediaItem,
//         AudioService.position,
//             (mediaItem, position) => AudioState(mediaItem, position));
//
// IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
//   icon: Icon(iconData),
//   iconSize: 64.0,
//   onPressed: onPressed,
// );
