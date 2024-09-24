import '../../../core/use_cases/use_case.dart';
import '../../data/models/radio_type.dart';
import '../entities/radio_station_entity.dart';
import '../repositories/radio_repository.dart';

class LanguageRadioStationsUserCase
    implements UseCase<List<RadioStationEntity>, String?> {
  final RadioRepository repository;

  LanguageRadioStationsUserCase({required this.repository});

  @override
  Future<List<RadioStationEntity>> call(String? language) async =>
      repository.searchByLanguage(language: language);

  Future<List<RadioType>> getAllLanguages() async =>
      repository.getAllLanguages();
}
