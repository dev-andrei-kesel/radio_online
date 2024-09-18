import 'package:flutter/material.dart';

import 'app_colors.dart';

class ColorsLight extends AppColors {
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

  ColorsLight({
    this.background = Colors.lightGreenAccent,
    this.onBackground = Colors.yellow,
    this.text = Colors.black,
    this.selected = Colors.black,
    this.unselected = Colors.lime,
  });

  @override
  ColorsLight copyWith({
    Color? background,
    Color? onBackground,
    Color? text,
    Color? selected,
    Color? unselected,
  }) {
    return ColorsLight(
      background: background ?? Colors.lightGreenAccent,
      onBackground: onBackground ?? Colors.yellow,
      text: text ?? Colors.black,
      selected: selected ?? Colors.black,
      unselected: selected ?? Colors.lime,
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
