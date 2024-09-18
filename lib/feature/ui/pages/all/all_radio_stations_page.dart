import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/usercases/get_all_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/all/all_radio_stations_cubit.dart';
import 'package:radio_online/feature/ui/pages/all/all_radio_stations_states.dart';

import '../../../../core/providers/repository_scope.dart';
import '../../widgets/radio_grid_widget.dart';

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
      )..call(null),
      child: BlocBuilder<AllRadioStationsCubit, AllRadioStationsStates>(
        builder: (context, state) {
          switch (state) {
            case AllRadioStationsLoadedState():
              return Container(
                  color: context.colors.background,
                  child: RadioGridWidget(
                    size: size,
                    stations: state.data,
                    onClick: (radioStationEntity) {
                      audioHandler?.playMediaItem(
                        MediaItem(
                          id: radioStationEntity.url ?? '',
                          title: radioStationEntity.name ?? '',
                          artUri: Uri.parse(radioStationEntity.favicon ?? ''),
                          duration: const Duration(milliseconds: 40000000),
                        ),
                      );
                    }
                  ),
              );
            case AllRadioStationsErrorState():
              return Container(
                color: context.colors.background,
                child: Center(
                  child: Text(
                    style: TextStyle(
                      color: context.colors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    state.failure.toString(),
                  ),
                ),
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
              return Container(
                color: context.colors.selected,
                child: const Center(
                  child: Text('No data'),
                ),
              );
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
    );
  }
}
