import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_online/feature/ui/pages/main/main_page.dart';

import '../domain/entities/radio_station_entity.dart';
import '../ui/pages/all/all_radio_stations_page.dart';
import '../ui/pages/country/radio_country_stations_page.dart';
import '../ui/pages/favourites/radio_favourites_page.dart';
import '../ui/pages/genre/radio_genre_stations_page.dart';
import '../ui/pages/info/info_radio_station_page.dart';
import '../ui/pages/language/radio_language_stations_page.dart';

class NavigationRouter {
  static AudioHandler? _audioHandler;

  static set audioHandler(AudioHandler audioHandler) =>
      _audioHandler = audioHandler;

  static GoRouter goRouter = GoRouter(
    initialLocation: '/all_radio_stations_page',
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: InfoRadioStationPage.routeName,
        builder: (context, state) => InfoRadioStationPage(
          radioStationEntity: state.extra as RadioStationEntity,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
              navigationShell: navigationShell, audioHandler: _audioHandler);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: AllRadioStationsPage.routeName,
                builder: (context, state) =>
                    AllRadioStationsPage(audioHandler: _audioHandler),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: RadioFavouritesPage.routeName,
                builder: (context, state) =>
                    RadioFavouritesPage(audioHandler: _audioHandler),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: RadioCountryPage.routeName,
                builder: (context, state) =>
                    RadioCountryPage(audioHandler: _audioHandler),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: RadioGenrePage.routeName,
                builder: (context, state) =>
                    RadioGenrePage(audioHandler: _audioHandler),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                path: RadioLanguagePage.routeName,
                builder: (context, state) =>
                    RadioLanguagePage(audioHandler: _audioHandler),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
