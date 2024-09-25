import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/domain/usercases/genre_radio_stations_user_case.dart';
import 'package:radio_online/feature/ui/pages/genre/radio_genre_stations_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../data/models/radio_type.dart';
import '../../../domain/entities/radio_station_entity.dart';

class RadioGenreStationsCubit extends Cubit<RadioGenreStationsStates> {
  final UseCase userCase;
  final List<RadioType> _genres = [];
  final List<RadioType> genres = [];
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
  RadioType? genre;
  String query = '';

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
          _stations.clear();
          _stations.addAll(result.data);
          emit(RadioGenreStationsLoadedState(data: _filteredStations));
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
    _genres.addAll(genres.reversed);
    return genres.reversed.toList();
  }

  Future<void> update(RadioType? genre) async {
    emit(RadioGenreStationsLoadingState());
    this.genre = genre;
    call(genre?.name);
  }

  Future<void> search(String query) async {
    this.query = query;
    List<RadioType> genres = _genres
        .where(
            (e) => e.name?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    List<RadioStationEntity> stations = _filteredStations;

    if (genres.isEmpty || query.isEmpty) {
      this.genres.clear();
      this.genres.addAll(_genres);
    } else {
      this.genres.clear();
      this.genres.addAll(genres);
    }

    if (stations.isEmpty) {
      emit(RadioGenreStationsEmptyState());
    } else {
      emit(
        RadioGenreStationsLoadedState(
            data: query.isEmpty ? _filteredStations : stations),
      );
    }
  }
}
