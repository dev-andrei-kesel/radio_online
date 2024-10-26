import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/main/radio_main_states.dart';

class RadioMainCubit extends Cubit<RadioMainStates> {
  IconData? icon = Icons.pause;
  String query = '';
  bool enable = false;

  bool? _isBluetoothEnabled;

  bool? get isBluetoothEnabled => _isBluetoothEnabled;

  static const platform =
      MethodChannel('by.radio.online.radio_online/bluetooth');
  static const stateChannel =
      EventChannel('by.radio.online.radio_online.flutter.dev/bluetooth/state');

  RadioMainCubit() : super(DefaultState()) {
    stateChannel.receiveBroadcastStream().listen(
      (dynamic event) {
        _isBluetoothEnabled = event as bool?;
        if (_isBluetoothEnabled == true) {
          emit(EnableBluetooth());
        } else {
          emit(DisableBluetooth());
        }
      },
    );
  }

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

  Future<void> getBluetoothState() async {
    bool? isBluetoothEnabled;
    try {
      final bool result = await platform.invokeMethod('getBluetoothState');
      isBluetoothEnabled = result;
      _isBluetoothEnabled = isBluetoothEnabled;
    } on PlatformException catch (e) {
      _isBluetoothEnabled = false;
      debugPrint('Failed to get Bluetooth state: ${e.message}');
    }

    if (isBluetoothEnabled == true) {
      emit(EnableBluetooth());
    } else {
      emit(DisableBluetooth());
    }
  }
}
