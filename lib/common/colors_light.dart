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
  Color chipSelected;
  @override
  Color unselected;

  ColorsLight({
    this.background = Colors.yellow,
    this.onBackground = Colors.white,
    this.text = Colors.black,
    this.selected = Colors.black,
    this.chipSelected = Colors.amber,
    this.unselected = Colors.white,
  });

  @override
  ColorsLight copyWith({
    Color? background,
    Color? onBackground,
    Color? text,
    Color? selected,
    Color? chipSelected,
    Color? unselected,
  }) {
    return ColorsLight(
      background: background ?? Colors.yellow,
      onBackground: onBackground ?? Colors.white,
      text: text ?? Colors.black,
      selected: selected ?? Colors.black,
      chipSelected: chipSelected ?? Colors.amber,
      unselected: unselected ?? Colors.white,
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
