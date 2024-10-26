import 'package:flutter/material.dart';
import 'package:radio_online/feature/ui/widgets/radio_rating_widget.dart';

import '../../domain/entities/radio_station_entity.dart';

class RadioStationsInfoWidget extends StatelessWidget {
  final RadioStationEntity? radioStationEntity;

  const RadioStationsInfoWidget({
    super.key,
    required this.radioStationEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('radioStationsInfoRow'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RadioRatingWidget(
          icon: Icons.star_rate,
          value: radioStationEntity?.votes == null
              ? '0'
              : radioStationEntity?.votes.toString(),
          color: Colors.orange,
        ),
        const SizedBox(width: 12.0),
        RadioRatingWidget(
          icon: Icons.map,
          value: radioStationEntity?.countryCode == null
              ? ''
              : radioStationEntity?.countryCode.toString().toUpperCase(),
          color: Colors.green,
        ),
        const SizedBox(width: 12.0),
        RadioRatingWidget(
          icon: Icons.language,
          value: radioStationEntity?.languageCodes == null
              ? ''
              : radioStationEntity?.languageCodes.toString().toUpperCase(),
          color: Colors.blue,
        )
      ],
    );
  }
}
