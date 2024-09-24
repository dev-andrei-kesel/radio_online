import 'package:radio_online/feature/data/models/radio_type.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

import '../../../core/use_cases/use_case.dart';
import '../repositories/radio_repository.dart';

class CountriesRadioStationsUserCase
    implements UseCase<List<RadioStationEntity>, String?> {
  final RadioRepository repository;

  CountriesRadioStationsUserCase({required this.repository});

  @override
  Future<List<RadioStationEntity>> call(String? params) async =>
      repository.searchByCountry(country: params);

  Future<List<RadioType>> getAllCountries() async =>
      repository.getAllCountries();
}
