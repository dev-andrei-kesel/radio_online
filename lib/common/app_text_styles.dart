import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final AppColors? colors;
  final TextStyle? title;
  final TextStyle? text;
  final TextStyle? header;

  const AppTextStyles({
    required this.colors,
    required this.title,
    required this.text,
    required this.header,
  });

  factory AppTextStyles.fromColors(AppColors? colors) {
    return AppTextStyles(
      colors: colors,
      title: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: colors?.text,
      ),
      text: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: colors?.text,
      ),
      header: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: colors?.text,
      ),
    );
  }

  @override
  ThemeExtension<AppTextStyles> copyWith() {
    return AppTextStyles.fromColors(colors);
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
      covariant ThemeExtension<AppTextStyles>? other, double t) {
    return this;
  }
}

extension BuildContextOn on BuildContext {
  AppTextStyles get styles => Theme.of(this).extension<AppTextStyles>()!;
}
