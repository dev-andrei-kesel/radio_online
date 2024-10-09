import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/data/models/radio_type.dart';
import 'package:radio_online/feature/ui/widgets/radio_horizontal_list_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void radioHorizontalListWidget() {
  group(
    'RadioHorizontalListWidget',
    () {
      final colorsDark = ColorsDark(
        background: Colors.black,
        selected: Colors.white,
        unselected: Colors.grey,
        text: Colors.white,
        chipSelected: Colors.blue,
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
        'renders correctly with radio types',
        (WidgetTester tester) async {
          final types = [
            const RadioType(name: 'Type 1', code: 'type1', stationcount: 10),
            const RadioType(name: 'Type 2', code: 'type2', stationcount: 20),
          ];
          RadioType? selectedType;

          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                extensions: [colorsDark, appTextStyles],
              ),
              home: Scaffold(
                body: RadioHorizontalListWidget(
                  types: types,
                  type: selectedType,
                  onSelected: (type) {
                    selectedType = type;
                  },
                  pageStorageBucket: PageStorageBucket(),
                  itemScrollController: ItemScrollController(),
                ),
              ),
            ),
          );

          expect(find.byType(ScrollablePositionedList), findsOneWidget);
          expect(find.byType(ChoiceChip), findsNWidgets(types.length));

          // Check if the labels are displayed correctly
          expect(find.text('Type 1'), findsOneWidget);
          expect(find.text('Type 2'), findsOneWidget);

          expect(find.text('10'), findsOneWidget);
          expect(find.text('20'), findsOneWidget);

          await tester.tap(find.byType(ChoiceChip).at(1));
          await tester.pump();

          expect(selectedType, types[1]);
        },
      );
    },
  );
}
