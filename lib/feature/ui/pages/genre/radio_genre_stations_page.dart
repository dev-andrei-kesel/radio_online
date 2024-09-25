import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/usercases/genre_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/genre/radio_genre_stations_cubit.dart';
import 'package:radio_online/feature/ui/pages/genre/radio_genre_stations_states.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../audio/audio_player_handler.dart';
import '../../../../core/providers/repository_scope.dart';
import '../../widgets/radio_empty_widget.dart';
import '../../widgets/radio_error_widget.dart';
import '../../widgets/radio_horizontal_list_widget.dart';
import '../../widgets/radio_vertical_list_widget.dart';
import '../main/radio_main_cubit.dart';
import '../main/radio_main_states.dart';

class RadioGenrePage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_genre_stations_page';
  final PageStorageBucket pageStorageBucket;
  final ItemScrollController? itemScrollController = ItemScrollController();

  RadioGenrePage({
    super.key,
    required this.audioHandler,
    required this.pageStorageBucket,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<RadioGenreStationsCubit>(
      create: (context) => RadioGenreStationsCubit(
        userCase: GenreRadioStationsUserCase(
          repository: RepositoryScope.of(context).repository,
        ),
      )..call(null),
      child: BlocListener<RadioMainCubit, RadioMainStates>(
        child: BlocBuilder<RadioGenreStationsCubit, RadioGenreStationsStates>(
          builder: (context, state) {
            RadioGenreStationsCubit cubit =
                context.read<RadioGenreStationsCubit>();
            switch (state) {
              case RadioGenreStationsLoadedState():
                return Container(
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.genres,
                        type: cubit.genre,
                        itemScrollController: itemScrollController,
                        pageStorageBucket: pageStorageBucket,
                        onSelected: (e) {
                          cubit.update(e);
                        },
                      ),
                      Expanded(
                        child: RadioVerticalListWidget(
                          null,
                          size: size,
                          isFavoriteScreen: false,
                          stations: state.data,
                          onClick: (radioStationEntity) {
                            (audioHandler as AudioPlayerHandler)
                                .setRadioStation(radioStationEntity);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              case RadioGenreStationsErrorState():
                return RadioErrorWidget(
                  failure: state.failure,
                  onSwipe: () {
                    cubit.update(
                      cubit.genre ?? cubit.genres.first,
                    );
                  },
                );
              case RadioGenreStationsLoadingState():
                return Container(
                  height: size.height,
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.genres,
                        type: cubit.genre,
                        itemScrollController: itemScrollController,
                        pageStorageBucket: pageStorageBucket,
                        onSelected: (e) {
                          cubit.update(e);
                        },
                      ),
                      Expanded(
                        child: Container(
                          color: context.colors.background,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: context.colors.text,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              case RadioGenreStationsEmptyState():
                return Container(
                  height: size.height,
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.genres,
                        type: cubit.genre,
                        itemScrollController: itemScrollController,
                        pageStorageBucket: pageStorageBucket,
                        onSelected: (e) {
                          cubit.update(e);
                        },
                      ),
                      Expanded(
                        child: Container(
                          height: size.height,
                          color: context.colors.background,
                          child: Center(
                              child: RadioEmptyWidget(height: size.height)),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return Container(
                  height: size.height,
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.genres,
                        type: cubit.genre,
                        itemScrollController: itemScrollController,
                        pageStorageBucket: pageStorageBucket,
                        onSelected: (e) {
                          cubit.update(e);
                        },
                      ),
                      Expanded(
                        child: Container(
                          height: size.height,
                          color: context.colors.background,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: context.colors.text,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
        listener: (context, state) {
          RadioGenreStationsCubit cubit =
              context.read<RadioGenreStationsCubit>();
          if (state is OnChanged) {
            cubit.search(state.query);
          }
          if (state is EnableSearch && !state.enable) {
            if (cubit.genre != null) {
              itemScrollController?.scrollTo(
                index: cubit.genres.indexOf(cubit.genre!),
                duration: const Duration(milliseconds: 500),
              );
            }
          }
        },
      ),
    );
  }
}
