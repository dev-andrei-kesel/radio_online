import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';

class RadioGenrePage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_genre_stations_page';
  const RadioGenrePage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('RadioGenrePage'));
  }
}