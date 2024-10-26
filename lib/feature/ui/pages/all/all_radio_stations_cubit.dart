import 'package:radio_online/core/result/result.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';
import 'package:radio_online/feature/ui/pages/all/all_radio_stations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/use_cases/use_case.dart';

class AllRadioStationsCubit extends Cubit<AllRadioStationsStates> {
  int _offset = 0;
  static const int _limit = 150;
  final UseCase userCase;
  List<RadioStationEntity> stations = [];
  bool isLoadData = true;
  bool isSearch = false;

  AllRadioStationsCubit({required this.userCase})
      : super(AllRadioStationsLoadingState());

  Future<void> call() async {
    final RadioResult result =
        await userCase.call(_limit, _offset * _limit, null).asResult();
    switch (result) {
      case Success():
        if (result.data.length < _limit) {
          isLoadData = false;
        }
        if (result.data == null) {
          emit(AllRadioStationsEmptyState());
        } else {
          stations.addAll(result.data);
          emit(AllRadioStationsLoadedState(data: stations));
        }
      case Error():
        emit(AllRadioStationsErrorState(failure: result.failure));
      case Loading():
        emit(AllRadioStationsLoadingState());
    }
  }

  Future<void> update() async {
    emit(AllRadioStationsLoadingState());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        stations.clear();
        call();
      },
    );
  }

  Future<void> paging() async {
    if (isLoadData) {
      if (state is AllRadioStationsLoadingState) return;
      _offset = _offset + 1;
      call();
    }
  }

  Future<void> search(String query) async {
    isSearch = query.isNotEmpty;
    if (state is! AllRadioStationsLoadingState) {
      List<RadioStationEntity> stations = this
          .stations
          .where((e) =>
              e.name?.toLowerCase().contains(query.toLowerCase()) == true ||
              e.country?.toLowerCase().contains(query.toLowerCase()) == true ||
              e.countryCode?.toLowerCase().contains(query.toLowerCase()) ==
                  true ||
              e.language?.toLowerCase().contains(query.toLowerCase()) == true ||
              e.languageCodes?.toLowerCase().contains(query.toLowerCase()) ==
                  true ||
              e.tags?.toLowerCase().contains(query.toLowerCase()) == true)
          .toList();
      if (stations.isEmpty) {
        emit(AllRadioStationsEmptyState());
      } else {
        emit(
          AllRadioStationsLoadedState(
              data: query.isEmpty ? this.stations : stations),
        );
      }
    }
  }
}
