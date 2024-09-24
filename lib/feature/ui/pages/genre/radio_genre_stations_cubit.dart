import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/domain/usercases/genre_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/genre/radio_genre_stations_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';

class RadioGenreStationsCubit extends Cubit<RadioGenreStationsStates> {
  final UseCase userCase;
  final List<RadioType> genres = [];
  RadioType? genre;

  RadioGenreStationsCubit({required this.userCase})
      : super(RadioGenreStationsLoadingState());

  Future<void> call(String? genre) async {
    if (this.genre == null) {
      this.genre = (await _saveGenres())?.first;
    }
    final RadioResult result =
        await userCase.call(genre ?? this.genre?.name).asResult();
    switch (result) {
      case Success():
        if (result.data == null || result.data.isEmpty) {
          emit(RadioGenreStationsEmptyState());
        } else {
          emit(RadioGenreStationsLoadedState(data: result.data));
        }
      case Error():
        emit(RadioGenreStationsErrorState(failure: result.failure));
      case Loading():
        emit(RadioGenreStationsLoadingState());
    }
  }

  Future<List<RadioType>?> _saveGenres() async {
    List<RadioType> genres =
        await (userCase as GenreRadioStationsUserCase).getAllGenres();
    genres.sort((a, b) => a.stationcount?.compareTo(b.stationcount ?? 0) ?? 0);
    this.genres.addAll(genres.reversed);
    return genres.reversed.toList();
  }

  Future<void> update(RadioType? genre) async {
    emit(RadioGenreStationsLoadingState());
    this.genre = genre;
    call(genre?.name);
  }
}
