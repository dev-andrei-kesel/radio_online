import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/core/providers/repository_scope.dart';
import 'package:radio_online/feature/domain/usercases/favourite_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/main/radio_main_cubit.dart';
import 'package:radio_online/feature/ui/widgets/bottom_navigation_bar.dart';

import '../../../../common/string_resources.dart';
import '../../widgets/radio_player_widget.dart';
import '../favourites/radio_favourites_cubit.dart';
import 'radio_main_states.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final AudioHandler? audioHandler;

  const MainScreen(
      {super.key, required this.navigationShell, required this.audioHandler});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioHandler = widget.audioHandler;
    final Size size = MediaQuery.of(context).size;
    return RepositoryScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RadioMainCubit>(
            create: (context) => RadioMainCubit(),
          ),
          BlocProvider<RadioFavouritesCubit>(
            create: (context) => RadioFavouritesCubit(
              userCase: FavouriteRadioStationsUserCase(
                repository: RepositoryScope.of(context).repository,
              ),
            )..call(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: context.colors.background,
            foregroundColor: context.colors.text,
            centerTitle: true,
            title: Text(style: context.styles.title, StringResources.title),
          ),
          body: BlocConsumer<RadioMainCubit, RadioMainStates>(
            builder: (context, state) => Stack(
              children: [
                widget.navigationShell,
                AnimatedBuilder(
                  animation: _animation,
                  child: Center(
                    child: Icon(
                      context.read<RadioMainCubit>().icon,
                      size: size.width,
                      color: Colors.white.withOpacity(0.35),
                    ),
                  ),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      child: child,
                    );
                  },
                ),
              ],
            ),
            listener: (context, state) {
              _playerStateHandler(state);
            },
          ),
          bottomNavigationBar: Container(
            color: context.colors.background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: StreamBuilder<PlaybackState>(
                    stream: audioHandler?.playbackState ??
                        Stream.value(PlaybackState()),
                    builder: (context, snapshot) {
                      final playbackState = snapshot.data;
                      return _isVisiblePlayer(playbackState)
                          ? RadioPlayerWidget(audioHandler: audioHandler)
                          : const SizedBox();
                    },
                  ),
                ),
                RadioBottomNavigationBar(
                  navigationShell: widget.navigationShell,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isVisiblePlayer(PlaybackState? playbackState) {
    return playbackState?.processingState.name ==
            ProcessingState.loading.name ||
        playbackState?.processingState.name == ProcessingState.buffering.name ||
        playbackState?.processingState.name == ProcessingState.ready.name;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      _controller,
    );
    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        }
      },
    );
  }

  void _playerStateHandler(RadioMainStates state) {
    switch (state) {
      case OnPlayState():
        _controller.forward();
      case OnPauseState():
        _controller.forward();
      case OnStopState():
        _controller.forward();
      case OnLikeState():
        _controller.forward();
      default:
        break;
    }
  }
}
