import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/usercases/get_all_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/all/all_radio_stations_cubit.dart';
import 'package:radio_online/feature/ui/pages/all/all_radio_stations_states.dart';

import '../../../../audio/audio_player_handler.dart';
import '../../../../core/providers/repository_scope.dart';
import '../../widgets/radio_empty_widget.dart';
import '../../widgets/radio_error_widget.dart';
import '../../widgets/radio_vertical_list_widget.dart';
import '../main/radio_main_cubit.dart';
import '../main/radio_main_states.dart';

class AllRadioStationsPage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/all_radio_stations_page';

  const AllRadioStationsPage({super.key, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<AllRadioStationsCubit>(
      create: (context) => AllRadioStationsCubit(
        userCase: GetAllRadioStationsUserCase(
          repository: RepositoryScope.of(context).repository,
        ),
      )..call(),
      child: BlocConsumer<RadioMainCubit, RadioMainStates>(
        builder: (context, state) =>
            BlocBuilder<AllRadioStationsCubit, AllRadioStationsStates>(
          builder: (context, state) {
            switch (state) {
              case AllRadioStationsLoadedState():
                return Container(
                  color: context.colors.background,
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
                );
              case AllRadioStationsErrorState():
                return RadioErrorWidget(
                  failure: state.failure,
                  onSwipe: () {
                    context.read<AllRadioStationsCubit>().update();
                  },
                );
              case AllRadioStationsLoadingState():
                return Container(
                  color: context.colors.background,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: context.colors.text,
                    ),
                  ),
                );
              case AllRadioStationsEmptyState():
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
            context.read<AllRadioStationsCubit>().search(state.query);
          }
        },
      ),
    );
  }
}
