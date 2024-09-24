import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/country/radio_country_stations_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';
import '../../../domain/usercases/countries_radio_stations_user_case.dart';

class RadioCountryStationsCubit extends Cubit<RadioCountryStationsStates> {
  final UseCase userCase;
  final List<RadioType> countries = [];
  RadioType? country;

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
          emit(RadioCountryStationsLoadedState(data: result.data));
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
    return countries.reversed.toList();
  }

  Future<void> update(RadioType? country) async {
    emit(RadioCountryStationsLoadingState());
    this.country = country;
    call(country?.name);
  }
}
