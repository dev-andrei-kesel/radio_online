import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/main/radio_main_states.dart';

class RadioMainCubit extends Cubit<RadioMainStates> {
  IconData? icon = Icons.pause;
  String query = '';
  bool enable = false;

  RadioMainCubit() : super(DefaultState());

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

  void onChanged(String query) {
    this.query = query.trim();
    emit(OnChanged(query: query));
  }

  void enableSearch(bool enable) {
    this.enable = enable;
    onChanged('');
    emit(EnableSearch(enable: enable));
  }
}
