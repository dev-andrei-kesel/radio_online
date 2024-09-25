import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/country/radio_country_stations_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';
import '../../../domain/entities/radio_station_entity.dart';
import '../../../domain/usercases/countries_radio_stations_user_case.dart';

class RadioCountryStationsCubit extends Cubit<RadioCountryStationsStates> {
  final UseCase userCase;
  final List<RadioType> _countries = [];
  final List<RadioType> countries = [];
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
  RadioType? country;
  String query = '';

  RadioCountryStationsCubit({required this.userCase})
      : super(RadioCountryStationsLoadingState());

  Future<void> call(String? country) async {
    if (this.country == null) {
      this.country = (await _saveCountries())?.first;
    }
    final RadioResult result =
        await userCase.call(country ?? this.country?.name).asResult();
    switch (result) {
      case Success():
        if (result.data == null || result.data.isEmpty) {
          emit(RadioCountryStationsEmptyState());
        } else {
          _stations.clear();
          _stations.addAll(result.data);
          emit(RadioCountryStationsLoadedState(data: _filteredStations));
        }
      case Error():
        emit(RadioCountryStationsErrorState(failure: result.failure));
      case Loading():
        emit(RadioCountryStationsLoadingState());
    }
  }

  Future<List<RadioType>?> _saveCountries() async {
    List<RadioType> countries =
        await (userCase as CountriesRadioStationsUserCase).getAllCountries();
    countries
        .sort((a, b) => a.stationcount?.compareTo(b.stationcount ?? 0) ?? 0);
    this.countries.addAll(countries.reversed);
    _countries.addAll(countries.reversed);
    return countries.reversed.toList();
  }

  Future<void> update(RadioType? country) async {
    emit(RadioCountryStationsLoadingState());
    this.country = country;
    call(country?.name);
  }

  Future<void> search(String query) async {
    this.query = query;
    List<RadioType> countries = _countries
        .where(
            (e) => e.name?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    List<RadioStationEntity> stations = _filteredStations;

    if (countries.isEmpty || query.isEmpty) {
      this.countries.clear();
      this.countries.addAll(_countries);
    } else {
      this.countries.clear();
      this.countries.addAll(countries);
    }

    if (stations.isEmpty) {
      emit(RadioCountryStationsEmptyState());
    } else {
      emit(
        RadioCountryStationsLoadedState(
            data: query.isEmpty ? _filteredStations : stations),
      );
    }
  }
}
