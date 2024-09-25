import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/usercases/language_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/language/radio_language_stations_cubit.dart';
import 'package:radio_online/feature/ui/pages/language/radio_language_stations_states.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../audio/audio_player_handler.dart';
import '../../../../core/providers/repository_scope.dart';
import '../../widgets/radio_empty_widget.dart';
import '../../widgets/radio_error_widget.dart';
import '../../widgets/radio_horizontal_list_widget.dart';
import '../../widgets/radio_vertical_list_widget.dart';
import '../main/radio_main_cubit.dart';
import '../main/radio_main_states.dart';

class RadioLanguagePage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_language_stations_page';
  final PageStorageBucket pageStorageBucket;
  final ItemScrollController? itemScrollController = ItemScrollController();

  RadioLanguagePage({
    super.key,
    required this.audioHandler,
    required this.pageStorageBucket,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<RadioLanguageStationsCubit>(
      create: (context) => RadioLanguageStationsCubit(
        userCase: LanguageRadioStationsUserCase(
          repository: RepositoryScope.of(context).repository,
        ),
      )..call(null),
      child: BlocListener<RadioMainCubit, RadioMainStates>(
        child: BlocBuilder<RadioLanguageStationsCubit,
            RadioLanguageStationsStates>(
          builder: (context, state) {
            RadioLanguageStationsCubit cubit =
                context.read<RadioLanguageStationsCubit>();
            switch (state) {
              case RadioLanguageStationsLoadedState():
                return Container(
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.languages,
                        type: cubit.language,
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
              case RadioLanguageStationsErrorState():
                return RadioErrorWidget(
                  failure: state.failure,
                  onSwipe: () {
                    cubit.update(
                      cubit.language ?? cubit.languages.first,
                    );
                  },
                );
              case RadioLanguageStationsLoadingState():
                return Container(
                  height: size.height,
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.languages,
                        type: cubit.language,
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
              case RadioLanguageStationsEmptyState():
                return Container(
                  height: size.height,
                  color: context.colors.background,
                  child: Column(
                    children: [
                      RadioHorizontalListWidget(
                        types: cubit.languages,
                        type: cubit.language,
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
                        types: cubit.languages,
                        type: cubit.language,
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
          RadioLanguageStationsCubit cubit =
              context.read<RadioLanguageStationsCubit>();
          if (state is OnChanged) {
            cubit.search(state.query);
          }
          if (state is EnableSearch && !state.enable) {
            if (cubit.language != null) {
              itemScrollController?.scrollTo(
                index: cubit.languages.indexOf(cubit.language!),
                duration: const Duration(milliseconds: 500),
              );
            }
          }
        },
      ),
    );
  }
}
