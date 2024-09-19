import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_online/common/app_text_styles.dart';
import 'package:radio_online/common/colors_dark.dart';
import 'package:radio_online/core/providers/repository_scope.dart';
import 'package:radio_online/feature/ui/widgets/bottom_navigation_bar.dart';

import '../../../../common/string_resources.dart';
import '../../widgets/radio_player_widget.dart';

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
      bottomNavigationBar: Container(
        color: context.colors.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: StreamBuilder<PlaybackState>(
                stream: audioHandler?.playbackState ??
                    Stream.value(PlaybackState()),
                builder: (context, snapshot) {
                  final playbackState = snapshot.data;
                  return _isVisiblePlayer(playbackState)
                      ? RadioPlayerWidget(audioHandler: audioHandler)
                      : const SizedBox();
                },
              ),
            ),
            RadioBottomNavigationBar(
              navigationShell: navigationShell,
            ),
          ],
        ),
      ),
    );
  }

  bool _isVisiblePlayer(PlaybackState? playbackState) {
    return playbackState?.processingState.name ==
            ProcessingState.loading.name ||
        playbackState?.processingState.name == ProcessingState.buffering.name ||
        playbackState?.processingState.name == ProcessingState.ready.name;
  }
}
