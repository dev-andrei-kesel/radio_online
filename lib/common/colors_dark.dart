
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
    this.background = Colors.green,
    this.onBackground = Colors.yellow,
    this.text = Colors.black,
    this.selected = Colors.black,
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
      background: background ?? Colors.green,
      onBackground: background ?? Colors.yellow,
      text: text ?? Colors.black,
      selected: selected ?? Colors.black,
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
