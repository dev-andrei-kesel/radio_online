import 'package:radio_online/core/result/result.dart';
import 'package:radio_online/feature/ui/pages/all/all_radio_stations_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/use_cases/use_case.dart';

class AllRadioStationsCubit extends Cubit<AllRadioStationsStates> {
  final UseCase userCase;

  AllRadioStationsCubit({required this.userCase})
      : super(AllRadioStationsLoadingState());

  Future<void> call(int? params) async {
    final RadioResult result = await userCase.call(params).asResult();
    switch (result) {
      case Success():
        if (result.data == null) {
          emit(AllRadioStationsEmptyState());
        } else {
          emit(AllRadioStationsLoadedState(data: result.data));
        }
      case Error():
        emit(AllRadioStationsErrorState(failure: result.failure));
      case Loading():
        emit(AllRadioStationsLoadingState());
    }
  }
}
