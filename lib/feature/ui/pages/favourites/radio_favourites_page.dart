
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';

class RadioFavouritesPage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_favourites_stations_page';
  const RadioFavouritesPage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('RadioFavouritesPage'));
  }
}