import 'package:radio_online/feature/domain/repositories/radio_repository.dart';

import '../../../core/use_cases/use_case.dart';
import '../entities/radio_station_entity.dart';

class GetAllRadioStationsUserCase
    extends UseCase<List<RadioStationEntity>?, String?> {
  final RadioRepository repository;

  GetAllRadioStationsUserCase({required this.repository});

  @override
  Future<List<RadioStationEntity>?> call(
    int? limit,
    int? offset,
    String? params,
  ) =>
      repository.getAllStations(
        limit: limit,
        offset: offset,
      );
}
