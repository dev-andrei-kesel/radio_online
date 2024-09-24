import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/usercases/genre_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/genre/radio_genre_stations_cubit.dart';
import 'package:radio_online/feature/ui/pages/genre/radio_genre_stations_states.dart';

import '../../../../audio/audio_player_handler.dart';
import '../../../../core/providers/repository_scope.dart';
import '../../widgets/radio_empty_widget.dart';
import '../../widgets/radio_error_widget.dart';
import '../../widgets/radio_horizontal_list_widget.dart';
import '../../widgets/radio_vertical_list_widget.dart';

class RadioGenrePage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_genre_stations_page';
  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  RadioGenrePage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<RadioGenreStationsCubit>(
      create: (context) => RadioGenreStationsCubit(
        userCase: GenreRadioStationsUserCase(
          repository: RepositoryScope.of(context).repository,
        ),
      )..call(null),
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
    );
  }
}
