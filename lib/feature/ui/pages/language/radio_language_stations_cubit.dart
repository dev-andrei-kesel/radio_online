import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/domain/usercases/language_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/language/radio_language_stations_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';

class RadioLanguageStationsCubit extends Cubit<RadioLanguageStationsStates> {
  final UseCase userCase;
  final List<RadioType> languages = [];
  RadioType? language;

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
          emit(RadioLanguageStationsLoadedState(data: result.data));
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
    return languages.reversed.toList();
  }

  Future<void> update(RadioType? language) async {
    emit(RadioLanguageStationsLoadingState());
    this.language = language;
    call(language?.name);
  }
}
