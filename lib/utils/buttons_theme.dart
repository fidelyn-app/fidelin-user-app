import 'package:flutter/material.dart';

@immutable
class AppButtonStyles extends ThemeExtension<AppButtonStyles> {
  final ButtonStyle primary;
  final ButtonStyle secondary;

  const AppButtonStyles({required this.primary, required this.secondary});

  @override
  AppButtonStyles copyWith({ButtonStyle? primary, ButtonStyle? secondary}) {
    return AppButtonStyles(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  AppButtonStyles lerp(ThemeExtension<AppButtonStyles>? other, double t) {
    if (other is! AppButtonStyles) return this;
    // Não existe lerp direto para ButtonStyle, então retornamos baseado em t
    return t < 0.5 ? this : other;
  }
}
