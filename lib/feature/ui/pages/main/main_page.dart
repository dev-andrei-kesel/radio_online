import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/core/providers/repository_scope.dart';
import 'package:radio_online/feature/ui/widgets/bottom_navigation_bar.dart';

import '../../../../common/string_resources.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final AudioHandler? audioHandler;

  const MainScreen(
      {super.key, required this.navigationShell, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.background,
        foregroundColor: context.colors.text,
        centerTitle: true,
        title: Text(style: context.styles.title, StringResources.title),
      ),
      body: RepositoryScope(
        child: navigationShell,
      ),
      bottomNavigationBar: RadioBottomNavigationBar(
        navigationShell: navigationShell,
      ),
    );
  }
}
