import '../../../core/use_cases/use_case.dart';
import '../../data/models/radio_type.dart';
import '../entities/radio_station_entity.dart';
import '../repositories/radio_repository.dart';

class GenreRadioStationsUserCase
    implements UseCase<List<RadioStationEntity>, String?> {
  final RadioRepository repository;

  GenreRadioStationsUserCase({required this.repository});

  @override
  Future<List<RadioStationEntity>> call(String? genre) async =>
      repository.searchByGenre(genre: genre);

  Future<List<RadioType>> getAllGenres() async => repository.getAllTags();
}
