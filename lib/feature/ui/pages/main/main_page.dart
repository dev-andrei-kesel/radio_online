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

import '../../../../audio/audio_player_handler.dart';
import '../../../../common/string_resources.dart';
import '../../widgets/radio_player_widget.dart';
import '../../widgets/wavy_text_widget.dart';
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
  late TextEditingController _searchController;

  @override
  void initState() {
    _initAnimation();
    _searchController = TextEditingController();
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
        child: BlocConsumer<RadioMainCubit, RadioMainStates>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: context.colors.background,
              foregroundColor: context.colors.text,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    RadioMainCubit cubit = context.read<RadioMainCubit>();
                    if (cubit.query.isNotEmpty) {
                      _searchController.text = '';
                      cubit.onChanged('');
                    } else {
                      !context.read<RadioMainCubit>().enable &&
                              context.read<RadioMainCubit>().query.isEmpty
                          ? cubit.enableSearch(true)
                          : cubit.enableSearch(false);
                    }
                  },
                  icon: Icon(!context.read<RadioMainCubit>().enable &&
                          context.read<RadioMainCubit>().query.isEmpty
                      ? Icons.search
                      : Icons.clear),
                ),
              ],
              title: context.read<RadioMainCubit>().enable
                  ? SearchBar(
                      controller: _searchController,
                      backgroundColor: WidgetStatePropertyAll(
                        context.colors.selected.withOpacity(0.15),
                      ),
                      hintText: StringResources.hintSearch,
                      hintStyle: WidgetStatePropertyAll(
                        TextStyle(
                          color: context.colors.selected.withOpacity(0.5),
                        ),
                      ),
                      textStyle: WidgetStatePropertyAll(
                        TextStyle(
                          color: context.colors.selected,
                        ),
                      ),
                      onChanged: (text) {
                        context.read<RadioMainCubit>().onChanged(text);
                      },
                      elevation: WidgetStateProperty.all(0),
                    )
                  : WavyTextWidget(
                      audioHandler: audioHandler,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      style: context.styles.title,
                      text: StringResources.title,
                    ),
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                widget.navigationShell,
                StreamBuilder<String>(
                  stream:
                      (audioHandler as AudioPlayerHandler).errorMessageStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.isNotEmpty == true) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                    content: Text(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      snapshot.data ?? '',
                                    ),
                                    action: SnackBarAction(
                                      textColor: Colors.white,
                                      label: StringResources.ok,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        audioHandler.closeSnackBar();
                                      },
                                    ),
                                  ),
                                )
                                .closed
                                .then(
                              (value) {
                                audioHandler.closeSnackBar();
                              },
                            );
                          },
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  child: Center(
                    child: Icon(
                      context.watch<RadioMainCubit>().icon,
                      size: size.width * 0.8,
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
            bottomNavigationBar: Container(
              color: context.colors.background,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: StreamBuilder<PlaybackState>(
                      stream: audioHandler.playbackState,
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
                    onTap: () {
                      _searchController.text = '';
                      context.read<RadioMainCubit>().enableSearch(false);
                    },
                  ),
                ],
              ),
            ),
          ),
          listener: (context, state) {
            _playerStateHandler(state);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    (widget.audioHandler as AudioPlayerHandler).dispose();
    super.dispose();
  }

  bool _isVisiblePlayer(PlaybackState? playbackState) {
    return playbackState?.processingState.name ==
            ProcessingState.loading.name ||
        playbackState?.processingState.name == ProcessingState.buffering.name ||
        playbackState?.processingState.name == ProcessingState.ready.name;
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
