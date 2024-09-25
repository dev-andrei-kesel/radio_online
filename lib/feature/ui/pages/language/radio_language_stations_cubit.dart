import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/domain/usercases/language_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/language/radio_language_stations_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';
import '../../../domain/entities/radio_station_entity.dart';

class RadioLanguageStationsCubit extends Cubit<RadioLanguageStationsStates> {
  final UseCase userCase;
  final List<RadioType> _languages = [];
  final List<RadioType> languages = [];
  final List<RadioStationEntity> _stations = [];

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
  RadioType? language;
  String query = '';

  RadioLanguageStationsCubit({required this.userCase})
      : super(RadioLanguageStationsLoadingState());

  Future<void> call(String? language) async {
    if (this.language == null) {
      this.language = (await _saveLanguages())?.first;
    }
    final RadioResult result =
        await userCase.call(language ?? this.language?.name).asResult();
    switch (result) {
      case Success():
        if (result.data == null || result.data.isEmpty) {
          emit(RadioLanguageStationsEmptyState());
        } else {
          _stations.clear();
          _stations.addAll(result.data);
          emit(RadioLanguageStationsLoadedState(data: _filteredStations));
        }
      case Error():
        emit(RadioLanguageStationsErrorState(failure: result.failure));
      case Loading():
        emit(RadioLanguageStationsLoadingState());
    }
  }

  Future<List<RadioType>?> _saveLanguages() async {
    List<RadioType> languages =
        await (userCase as LanguageRadioStationsUserCase).getAllLanguages();
    languages
        .sort((a, b) => a.stationcount?.compareTo(b.stationcount ?? 0) ?? 0);
    this.languages.addAll(languages.reversed);
    _languages.addAll(languages.reversed);
    return languages.reversed.toList();
  }

  Future<void> update(RadioType? language) async {
    emit(RadioLanguageStationsLoadingState());
    this.language = language;
    call(language?.name);
  }

  Future<void> search(String query) async {
    if (state is! RadioLanguageStationsLoadingState) {
      this.query = query;
      List<RadioType> languages = _languages
          .where((e) =>
              e.name?.toLowerCase().contains(query.toLowerCase()) == true)
          .toList();

      List<RadioStationEntity> stations = _filteredStations;

      if (languages.isEmpty || query.isEmpty) {
        this.languages.clear();
        this.languages.addAll(_languages);
      } else {
        this.languages.clear();
        this.languages.addAll(languages);
      }

      if (stations.isEmpty) {
        emit(RadioLanguageStationsEmptyState());
      } else {
        emit(
          RadioLanguageStationsLoadedState(
              data: query.isEmpty ? _filteredStations : stations),
        );
      }
    }
  }
}
