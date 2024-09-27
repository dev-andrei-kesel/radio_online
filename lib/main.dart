import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:radio_online/common/app_colors.dart';
import 'package:sqflite/sqflite.dart';
import 'audio/audio_player_handler.dart';
import 'common/app_text_styles.dart';
import 'common/colors_dark.dart';
import 'common/colors_light.dart';
import 'common/string_resources.dart';
import 'feature/navigation/navigation_router.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() async {
  NavigationRouter.audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler()..requestNotificationPermission(),
    config: const AudioServiceConfig(
      androidNotificationChannelId:
          StringResources.androidNotificationChannelId,
      androidNotificationChannelName:
          StringResources.androidNotificationChannelName,
    ),
  );

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppColors colorsDark = ColorsDark();
    AppColors colorsLight = ColorsLight();
    return MaterialApp.router(
      title: StringResources.title,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        extensions: [colorsDark, AppTextStyles.fromColors(colorsDark)],
        useMaterial3: true,
      ),
      theme: ThemeData(
        extensions: [colorsLight, AppTextStyles.fromColors(colorsLight)],
        useMaterial3: true,
      ),
      routerConfig: NavigationRouter.goRouter,
    );
  }
}
