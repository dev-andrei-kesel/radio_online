import 'package:flutter/cupertino.dart';
import 'package:radio_online/feature/ui/widgets/radio_station_widget.dart';

import '../../domain/entities/radio_station_entity.dart';

class RadioVerticalListWidget extends StatelessWidget {
  final bool isFavoriteScreen;
  final List<RadioStationEntity>? stations;
  final Size size;
  final Function(RadioStationEntity?) onClick;
  final Function(RadioStationEntity?)? onDeleteStation;

  const RadioVerticalListWidget(
    this.onDeleteStation, {
    super.key,
    required this.size,
    required this.stations,
    required this.onClick,
    required this.isFavoriteScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations?.length ?? 0,
      itemBuilder: (context, index) {
        return RadioStationWidget(
          isFavoriteScreen: isFavoriteScreen,
          radioStationEntity: stations?[index],
          size: size,
          onClick: onClick,
          onDeleteStation,
        );
      },
    );
  }
}
