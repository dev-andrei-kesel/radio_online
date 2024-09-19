import 'package:flutter/material.dart';

import 'app_colors.dart';

class ColorsDark extends AppColors {
  @override
  Color background;
  @override
  Color onBackground;
  @override
  Color text;
  @override
  Color selected;
  @override
  Color unselected;

  ColorsDark({
    this.background = Colors.black,
    this.onBackground = Colors.brown,
    this.text = Colors.white,
    this.selected = Colors.white,
    this.unselected = Colors.white30,
  });

  @override
  ColorsDark copyWith({
    Color? background,
    Color? onBackground,
    Color? text,
    Color? selected,
    Color? unselected,
  }) {
    return ColorsDark(
      background: background ?? Colors.black,
      onBackground: onBackground ?? Colors.brown,
      text: text ?? Colors.white,
      selected: selected ?? Colors.white,
      unselected: unselected ?? Colors.white30,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    return this;
  }
}

extension BuildContextOn on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
