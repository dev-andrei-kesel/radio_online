import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';

class RadioCountryPage extends StatelessWidget {
  final AudioHandler? audioHandler;
  static const String routeName = '/radio_country_stations_page';

  const RadioCountryPage({super.key, this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('RadioCountryPage'));
  }
}
