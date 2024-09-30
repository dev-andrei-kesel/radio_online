import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';
import 'package:radio_online/feature/ui/widgets/radio_rating_widget.dart';
import 'package:radio_online/feature/ui/widgets/radio_stations_info_widget.dart';

void radioStationsInfoWidgetTest() {
  group(
    'RadioStationsInfoWidget',
    () {
      final colorsDark = ColorsDark(
        background: Colors.black,
        selected: Colors.white,
        unselected: Colors.grey,
        text: Colors.white,
      );
      final appTextStyles = AppTextStyles(
        title: const TextStyle(fontSize: 16, color: Colors.white),
        text: const TextStyle(fontSize: 14, color: Colors.grey),
        header: const TextStyle(fontSize: 18, color: Colors.white),
        name: const TextStyle(fontSize: 12, color: Colors.grey),
        nameBold: const TextStyle(
            fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        colors: colorsDark,
      );

      testWidgets(
        'renders correctly with radio station data',
        (WidgetTester tester) async {
          const radioStationEntity = RadioStationEntity(
            stationUuid: 'uuid',
            name: 'station name',
            url: 'url',
            urlResolved: 'urlResolved',
            homepage: 'homepage',
            favicon: 'favicon',
            tags: 'tag1,tag2,tag3',
            country: 'country',
            votes: 100,
            countryCode: 'us',
            languageCodes: 'en',
            language: 'english',
            codec: '',
            isFavourite: null,
          );

          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                extensions: [colorsDark, appTextStyles],
              ),
              home: const Scaffold(
                body: RadioStationsInfoWidget(
                  radioStationEntity: radioStationEntity,
                ),
              ),
            ),
          );

          // Use find.byKey to target the specific Row widget
          expect(find.byKey(const Key('radioStationsInfoRow')), findsOneWidget);
          expect(find.byType(RadioRatingWidget), findsNWidgets(3));

          expect(find.text('100'), findsOneWidget);
          expect(find.text('US'), findsOneWidget);
          expect(find.text('EN'), findsOneWidget);
        },
      );
    },
  );
}
