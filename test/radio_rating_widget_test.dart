import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/ui/widgets/radio_rating_widget.dart';

void radioRatingWidgetTest() {
  group(
    'RadioRatingWidget',
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
        'renders correctly with icon, value, and color',
        (WidgetTester tester) async {
          const icon = Icons.star;
          const value = '4.5';
          const color = Colors.amber;

          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                extensions: [colorsDark, appTextStyles],
              ),
              home: Builder(
                builder: (context) => Theme(
                  data: Theme.of(context).copyWith(
                    extensions: [colorsDark, appTextStyles],
                  ),
                  child: const RadioRatingWidget(
                    icon: icon,
                    value: value,
                    color: color,
                  ),
                ),
              ),
            ),
          );

          expect(find.byIcon(icon), findsOneWidget);
          expect(find.text(value), findsOneWidget);
          expect((tester.firstWidget(find.byIcon(icon)) as Icon).color,
              equals(color));
          expect((tester.firstWidget(find.text(value)) as Text).style,
              equals(appTextStyles.header)); // Check if the style is applied
        },
      );

      testWidgets(
        'renders correctly with null value',
        (WidgetTester tester) async {
          const icon = Icons.star;
          const color = Colors.amber;

          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                extensions: [colorsDark, appTextStyles],
              ),
              home: Builder(
                builder: (context) => Theme(
                  data: Theme.of(context).copyWith(
                    extensions: [colorsDark, appTextStyles],
                  ),
                  child: const RadioRatingWidget(
                    icon: icon,
                    value: null, // Null value
                    color: color,
                  ),
                ),
              ),
            ),
          );

          expect(find.byIcon(icon), findsOneWidget);
          expect(find.text(''), findsOneWidget); // Expect empty string
          expect((tester.firstWidget(find.byIcon(icon)) as Icon).color,
              equals(color));
        },
      );
    },
  );
}
