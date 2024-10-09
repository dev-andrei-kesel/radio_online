import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/cubit/radio_types_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';
import '../../../domain/entities/radio_station_entity.dart';

class RadioTypesCubit extends Cubit<RadioTypesStates> {
  int _offset = 0;
  static const int _limit = 150;
  final UseCase userCase;
  final List<RadioType> _types = [];
  final List<RadioType> types = [];
  final List<RadioStationEntity> _stations = [];
  bool isLoadData = true;
  bool isSearch = false;

  List<RadioStationEntity> get _filteredStations => _stations
      .where((e) =>
          e.name?.toLowerCase().contains(query.toLowerCase()) == true ||
          e.country?.toLowerCase().contains(query.toLowerCase()) == true ||
          e.countryCode?.toLowerCase().contains(query.toLowerCase()) == true ||
          e.language?.toLowerCase().contains(query.toLowerCase()) == true ||
          e.languageCodes?.toLowerCase().contains(query.toLowerCase()) ==
              true ||
          e.tags?.toLowerCase().contains(query.toLowerCase()) == true)
      .toList();
  RadioType? type;
  String query = '';

  RadioTypesCubit({required this.userCase}) : super(LoadingState());

  Future<void> call(String? type) async {
    if (this.type == null) {
      this.type = (await _saveTypes())?.first;
    }
    final RadioResult result = await userCase
        .call(_limit, _offset * _limit, type ?? this.type?.name)
        .asResult();
    switch (result) {
      case Success():
        if (result.data.length < _limit) {
          isLoadData = false;
        }
        if (result.data == null || result.data.isEmpty) {
          emit(EmptyState());
        } else {
          _stations.addAll(result.data);
          if (_filteredStations.isNotEmpty) {
            emit(LoadedState(data: _filteredStations));
          } else {
            emit(EmptyState());
          }
        }
      case Error():
        emit(ErrorState(failure: result.failure));
      case Loading():
        emit(LoadingState());
    }
  }

  Future<List<RadioType>?> _saveTypes() async {
    List<RadioType> types = await userCase.get();
    types.sort((a, b) => a.stationcount?.compareTo(b.stationcount ?? 0) ?? 0);
    this.types.addAll(types.reversed);
    _types.addAll(types.reversed);
    return types.reversed.toList();
  }

  Future<void> update(RadioType? type) async {
    emit(LoadingState());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        this.type = type;
        _stations.clear();
        _offset = 0;
        call(type?.name);
      },
    );
  }

  Future<void> paging() async {
    if (isLoadData) {
      if (state is LoadingState) return;
      _offset = _offset + 1;
      call(type?.name);
    }
  }

  Future<void> search(String query) async {
    isSearch = query.isNotEmpty;
    if (state is! LoadingState) {
      this.query = query;
      List<RadioType> types = _types
          .where((e) =>
              e.name?.toLowerCase().contains(query.toLowerCase()) == true)
          .toList();

      List<RadioStationEntity> stations = _filteredStations;

      if (types.isEmpty || query.isEmpty) {
        this.types.clear();
        this.types.addAll(_types);
      } else {
        this.types.clear();
        this.types.addAll(types);
      }

      if (stations.isEmpty) {
        emit(EmptyState());
      } else {
        emit(
          LoadedState(data: query.isEmpty ? _filteredStations : stations),
        );
      }
    }
  }
}
