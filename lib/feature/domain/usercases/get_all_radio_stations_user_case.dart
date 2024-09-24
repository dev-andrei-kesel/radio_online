import 'package:radio_online/feature/domain/repositories/radio_repository.dart';

import '../../../core/use_cases/use_case.dart';
import '../entities/radio_station_entity.dart';

class GetAllRadioStationsUserCase<Params>
    extends UseCase<List<RadioStationEntity>?, Params> {
  final RadioRepository repository;

  GetAllRadioStationsUserCase({required this.repository});

  @override
  Future<List<RadioStationEntity>?> call(Params? params) async =>
      repository.getAllStations();
}
