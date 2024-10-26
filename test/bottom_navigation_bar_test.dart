import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/feature/ui/widgets/bottom_navigation_bar.dart';

class MockStatefulNavigationShell extends Mock
    with Diagnosticable
    implements StatefulNavigationShell {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }

  @override
  int get currentIndex => 0;
}

void radioBottomNavigationBarTest() {
  group(
    'RadioBottomNavigationBar',
    () {
      late RadioBottomNavigationBar bottomNavigationBar;
      late MockStatefulNavigationShell navigationShell;

      setUp(
        () {
          navigationShell = MockStatefulNavigationShell();
          bottomNavigationBar = RadioBottomNavigationBar(
            navigationShell: navigationShell,
            onTap: () {},
          );
        },
      );

      testWidgets('renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              extensions: [ColorsDark()],
            ),
            home: Scaffold(
              body: bottomNavigationBar,
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.byIcon(Icons.radio), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.map_outlined), findsOneWidget);
        expect(find.byIcon(Icons.music_note), findsOneWidget);
        expect(find.byIcon(Icons.language), findsOneWidget);
      });

      testWidgets(
        'calls onTap and goBranch on tap',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                extensions: [ColorsDark()],
              ),
              home: Scaffold(
                body: bottomNavigationBar,
              ),
            ),
          );

          await tester.tap(find.byIcon(Icons.favorite));
          await tester.pumpAndSettle();

          verify(navigationShell.goBranch(1, initialLocation: false)).called(1);
        },
      );
    },
  );
}
