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
              toolbarHeight: 80,
              backgroundColor: context.colors.background,
              foregroundColor: context.colors.text,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    RadioMainCubit cubit =
                        BlocProvider.of<RadioMainCubit>(context);
                    if (cubit.query.isNotEmpty) {
                      _searchController.text = '';
                      cubit.onSearch(cubit.query);
                    } else {
                      !context.read<RadioMainCubit>().enable &&
                              context.read<RadioMainCubit>().query.isEmpty
                          ? cubit.enableSearch(true)
                          : cubit.enableSearch(false);
                    }
                  },
                  icon: Icon(
                    !context.read<RadioMainCubit>().enable &&
                            context.read<RadioMainCubit>().query.isEmpty
                        ? Icons.search
                        : context.read<RadioMainCubit>().enable &&
                                context.read<RadioMainCubit>().query.isEmpty
                            ? Icons.clear
                            : Icons.search,
                  ),
                ),
              ],
              title: context.read<RadioMainCubit>().enable
                  ? SearchBar(
                      controller: _searchController,
                      backgroundColor: WidgetStatePropertyAll(
                          context.colors.unselected.withOpacity(0.75)),
                      hintText: StringResources.hintSearch,
                      onChanged: (text) {
                        BlocProvider.of<RadioMainCubit>(context)
                            .onChanged(text);
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
              children: [
                widget.navigationShell,
                AnimatedBuilder(
                  animation: _animation,
                  child: Center(
                    child: Icon(
                      context.watch<RadioMainCubit>().icon,
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
          listener: (context, state) {
            _playerStateHandler(state);
          },
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
    _searchController.dispose();
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
