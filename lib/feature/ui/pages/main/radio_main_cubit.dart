import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/main/radio_main_states.dart';

class RadioMainCubit extends Cubit<RadioMainStates> {
  IconData? icon = Icons.pause;

  RadioMainCubit(super.initialState);

  Future<void> onPlay() async {
    icon = Icons.play_arrow;
    emit(OnPlayState());
  }

  Future<void> onPause() async {
    icon = Icons.pause;
    emit(OnPauseState());
  }

  Future<void> onStop() async {
    icon = Icons.stop;
    emit(OnStopState());
  }

  Future<void> onLike() async {
    icon = Icons.favorite;
    emit(OnLikeState());
  }
}
