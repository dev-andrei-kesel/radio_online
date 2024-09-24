abstract class RadioMainStates {}

class DefaultState extends RadioMainStates {}

class OnPlayState extends RadioMainStates {}

class OnPauseState extends RadioMainStates {}

class OnStopState extends RadioMainStates {}

class OnLikeState extends RadioMainStates {}

class OnSearch extends RadioMainStates {
  final String query;

  OnSearch({required this.query});
}

class OnChanged extends RadioMainStates {
  final String query;

  OnChanged({required this.query});
}

class EnableSearch extends RadioMainStates {
  final bool enable;

  EnableSearch({required this.enable});
}
