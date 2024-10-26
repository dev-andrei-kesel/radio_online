import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:radio_online/common/colors_dark.dart';

class RadioBottomNavigationBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final VoidCallback onTap;

  const RadioBottomNavigationBar({
    super.key,
    required this.navigationShell,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return _RadioBottomNavigationBarState();
  }
}

class _RadioBottomNavigationBarState extends State<RadioBottomNavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final navigationShell = widget.navigationShell;
    return BottomNavigationBar(
      backgroundColor: context.colors.background,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: context.colors.background,
          icon: const Icon(Icons.radio),
          label: 'All',
        ),
        BottomNavigationBarItem(
          backgroundColor: context.colors.background,
          icon: const Icon(Icons.favorite),
          label: 'Liked',
        ),
        BottomNavigationBarItem(
          backgroundColor: context.colors.background,
          icon: const Icon(Icons.map_outlined),
          label: 'Countries',
        ),
        BottomNavigationBarItem(
          backgroundColor: context.colors.background,
          icon: const Icon(Icons.music_note),
          label: 'Genres',
        ),
        BottomNavigationBarItem(
          backgroundColor: context.colors.background,
          icon: const Icon(Icons.language),
          label: 'Languages',
        ),
      ],
      currentIndex: navigationShell.currentIndex,
      selectedItemColor: context.colors.selected,
      unselectedItemColor: context.colors.unselected,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
          color: context.colors.selected, fontWeight: FontWeight.bold),
      onTap: (index) {
        widget.onTap();
        _goBranch(index: index, navigationShell: navigationShell);
      },
      useLegacyColorScheme: false,
    );
  }

  void _goBranch(
      {required int index, required StatefulNavigationShell navigationShell}) {
    this.index = index;
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
