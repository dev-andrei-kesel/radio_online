import 'package:flutter/cupertino.dart';
import 'package:radio_online/feature/ui/widgets/radio_station_widget.dart';

import '../../domain/entities/radio_station_entity.dart';

class RadioGridWidget extends StatelessWidget {
  final List<RadioStationEntity>? stations;
  final Size size;
  final Function(RadioStationEntity) onClick;

  const RadioGridWidget(
      {super.key,
      required this.size,
      required this.stations,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return RadioStationWidget(
          radioStationEntity: stations![index],
          size: size,
          onClick: onClick,
        );
      },
    );
  }
}
