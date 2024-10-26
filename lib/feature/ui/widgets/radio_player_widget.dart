import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';

import '../../../audio/audio_player_handler.dart';
import '../../../common/string_resources.dart';
import '../pages/favourites/radio_favourite_states.dart';
import '../pages/favourites/radio_favourites_cubit.dart';
import '../pages/main/radio_main_cubit.dart';

class RadioPlayerWidget extends StatefulWidget {
  final AudioHandler? audioHandler;

  const RadioPlayerWidget({super.key, required this.audioHandler});

  @override
  State<StatefulWidget> createState() {
    return _RadioPlayerWidgetState();
  }
}

class _RadioPlayerWidgetState extends State<RadioPlayerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controllerIcon;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animationIcon;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioHandler = widget.audioHandler;
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
                      return AnimatedBuilder(
                        animation: _animationIcon,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 + _animationIcon.value * 0.2,
                            child: Transform.rotate(
                              angle: _animation.value * 2 * 3.14,
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundImage: NetworkImage(
                                  Uri.parse(mediaItem.artUri
                                                  .toString()
                                                  .isNotEmpty ==
                                              true
                                          ? mediaItem.artUri.toString()
                                          : StringResources.imageUrl)
                                      .toString(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          mediaItem.displayTitle.toString(),
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
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<RadioMainCubit>().onStop();
                        audioHandler?.stop();
                      },
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
                                  context.read<RadioMainCubit>().onPause();
                                  audioHandler?.pause();
                                },
                                icon: Icon(
                                    color: context.colors.selected,
                                    Icons.pause),
                              )
                            : IconButton(
                                onPressed: () {
                                  context.read<RadioMainCubit>().onPlay();
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
                      onPressed: () {
                        context.read<RadioMainCubit>().onLike();
                        _onPressedFavourite(context);
                      },
                      icon: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 + _animationIcon.value * 0.2,
                            child: BlocBuilder<RadioFavouritesCubit,
                                RadioFavouriteStates>(
                              builder: (context, state) {
                                final station =
                                    (audioHandler as AudioPlayerHandler)
                                        .station;
                                switch (state) {
                                  case FavouriteRadioStationsEmptyState():
                                    return const Icon(
                                      color: Colors.white,
                                      Icons.favorite,
                                    );
                                  case FavouriteRadioStationsLoadedState():
                                    return Icon(
                                      color: state.data?.any(
                                        (element) =>
                                            element.stationUuid ==
                                            station?.stationUuid,
                                      )
                                          ? Colors.red
                                          : Colors.white,
                                      Icons.favorite,
                                    );
                                  default:
                                    return Icon(
                                      color: station?.isFavourite == true
                                          ? Colors.red
                                          : Colors.white,
                                      Icons.favorite,
                                    );
                                }
                              },
                            ),
                          );
                        },
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

  void _onPressedFavourite(BuildContext context) {
    final station = (widget.audioHandler as AudioPlayerHandler).station;
    if (station?.isFavourite == false) {
      (widget.audioHandler as AudioPlayerHandler).station = station?.copyWith(
        isFavourite: true,
      );
      context.read<RadioFavouritesCubit>().addFavouriteRadioStations(station);
    } else {
      (widget.audioHandler as AudioPlayerHandler).station = station?.copyWith(
        isFavourite: false,
      );
      context
          .read<RadioFavouritesCubit>()
          .removeFavouriteRadioStations(station);
    }
  }

  @override
  void dispose() {
    _controllerIcon.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _initAnimation() {
    _controllerIcon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      _controller..repeat(),
    );
    _animationIcon = Tween(begin: 0.0, end: 1.0).animate(
      _controllerIcon..repeat(reverse: true),
    );
    widget.audioHandler?.playbackState.listen(
      (state) {
        try {
          if (state.playing) {
            _controllerIcon.repeat(reverse: true);
            _controller.repeat();
          } else {
            _controllerIcon.stop(canceled: false);
            _controller.stop();
          }
        } catch (e) {
          debugPrint(
            e.toString(),
          );
        }
      },
    );
  }
}
