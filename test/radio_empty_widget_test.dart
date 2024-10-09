import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/common/string_resources.dart';
import 'package:radio_online/feature/ui/widgets/radio_empty_widget.dart';

void radioEmptyWidgetTest() {
  group(
    'RadioEmptyWidget',
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
      testWidgets('renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              extensions: [colorsDark, appTextStyles],
            ),
            home: const Scaffold(
              // Wrap RadioEmptyWidget with SizedBox to constrain its height
              body: SizedBox(
                height: 300, // Adjust the height as needed
                child: RadioEmptyWidget(),
              ),
            ),
          ),
        );

        // Use find.byKey to target the specific Center widget
        expect(find.byKey(const Key('radioEmptyWidgetCenter')), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byIcon(Icons.headset_off), findsOneWidget);
        expect(find.text(StringResources.emptyMessage), findsOneWidget);
      });

      testWidgets(
        'renders with custom height',
        (WidgetTester tester) async {
          const double customHeight = 200.0;

          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                extensions: [colorsDark, appTextStyles],
              ),
              home: const Scaffold(
                // Remove the SizedBox or adjust its height to customHeight
                body: RadioEmptyWidget(height: customHeight),
              ),
            ),
          );

          // Find the Container widget
          final containerFinder = find.byType(Container);

          // Expect the Container to have the custom height
          expect(tester.getSize(containerFinder).height, customHeight);
        },
      );
    },
  );
}
