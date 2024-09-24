import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/ui/pages/country/radio_country_stations_cubit.dart';
import 'package:radio_online/feature/ui/pages/country/radio_country_stations_states.dart';

import '../../../../audio/audio_player_handler.dart';
import '../../../../core/providers/repository_scope.dart';
import '../../../domain/usercases/countries_radio_stations_user_case.dart';
import '../../widgets/radio_empty_widget.dart';
import '../../widgets/radio_error_widget.dart';
import '../../widgets/radio_horizontal_list_widget.dart';
import '../../widgets/radio_vertical_list_widget.dart';

class RadioCountryPage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_country_stations_page';
  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  RadioCountryPage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<RadioCountryStationsCubit>(
      create: (context) => RadioCountryStationsCubit(
        userCase: CountriesRadioStationsUserCase(
          repository: RepositoryScope.of(context).repository,
        ),
      )..call(null),
      child: BlocBuilder<RadioCountryStationsCubit, RadioCountryStationsStates>(
        builder: (context, state) {
          RadioCountryStationsCubit cubit =
              context.read<RadioCountryStationsCubit>();
          switch (state) {
            case RadioCountryStationsLoadedState():
              return Container(
                color: context.colors.background,
                child: Column(
                  children: [
                    RadioHorizontalListWidget(
                      types: cubit.countries,
                      type: cubit.country,
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
            case RadioCountryStationsErrorState():
              return RadioErrorWidget(
                failure: state.failure,
                onSwipe: () {
                  cubit.update(
                    cubit.country ?? cubit.countries.first,
                  );
                },
              );
            case RadioCountryStationsLoadingState():
              return Container(
                height: size.height,
                color: context.colors.background,
                child: Column(
                  children: [
                    RadioHorizontalListWidget(
                      types: cubit.countries,
                      type: cubit.country,
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
            case RadioCountryStationsEmptyState():
              return Container(
                height: size.height,
                color: context.colors.background,
                child: Column(
                  children: [
                    RadioHorizontalListWidget(
                      types: cubit.countries,
                      type: cubit.country,
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
                      types: cubit.countries,
                      type: cubit.country,
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
