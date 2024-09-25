import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/ui/pages/favourites/radio_favourite_states.dart';
import 'package:radio_online/feature/ui/pages/favourites/radio_favourites_cubit.dart';

import '../../../../audio/audio_player_handler.dart';
import '../../widgets/radio_empty_widget.dart';
import '../../widgets/radio_error_widget.dart';
import '../../widgets/radio_vertical_list_widget.dart';
import '../main/radio_main_cubit.dart';
import '../main/radio_main_states.dart';

class RadioFavouritesPage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_favourites_stations_page';

  const RadioFavouritesPage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<RadioMainCubit, RadioMainStates>(
      child: BlocBuilder<RadioFavouritesCubit, RadioFavouriteStates>(
        builder: (context, state) {
          switch (state) {
            case FavouriteRadioStationsLoadedState():
              return Container(
                color: context.colors.background,
                child: RadioVerticalListWidget(
                  size: size,
                  isFavoriteScreen: true,
                  stations: state.data,
                  onClick: (radioStationEntity) {
                    (audioHandler as AudioPlayerHandler)
                        .setRadioStation(radioStationEntity);
                  },
                  (radioStationEntity) {
                    (audioHandler as AudioPlayerHandler).station =
                        (audioHandler as AudioPlayerHandler)
                            .station
                            ?.copyWith(isFavourite: false);
                    context
                        .read<RadioFavouritesCubit>()
                        .removeFavouriteRadioStations(radioStationEntity);
                  },
                ),
              );
            case FavouriteRadioStationsErrorState():
              return RadioErrorWidget(
                failure: state.failure,
                onSwipe: null,
              );
            case FavouriteRadioStationsLoadingState():
              return Container(
                color: context.colors.background,
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.colors.text,
                  ),
                ),
              );
            case FavouriteRadioStationsEmptyState():
              return const RadioEmptyWidget();
            default:
              return Container(
                color: context.colors.background,
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.colors.text,
                  ),
                ),
              );
          }
        },
      ),
      listener: (context, state) {
        if (state is OnChanged) {
          context.read<RadioFavouritesCubit>().search(state.query);
        }
      },
    );
  }
}
