import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';

class RadioLanguagePage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_language_stations_page';
  const RadioLanguagePage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('RadioLanguagePage'));
  }
}