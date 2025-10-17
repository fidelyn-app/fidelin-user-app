import 'package:flutter/material.dart';

class Style {
  final String id;
  final Color colorPrimary;
  final Color colorSecondary;
  final bool pointShowNumbers;
  final double pointBorderRadius;
  final String? backgroundUrl;
  final String? title;
  final String? subtitle;

  Style({
    required this.id,
    required this.colorPrimary,
    required this.colorSecondary,
    this.pointShowNumbers = false,
    this.pointBorderRadius = 5.0,
    this.backgroundUrl,
    this.title,
    this.subtitle,
  });

  /// Cria uma instância a partir do JSON retornado pelo backend.
  /// Espera chaves como: color_primary, color_secondary,
  /// point_show_numbers, point_border_radius, point_background_url, background_url, title, subtitle.
  factory Style.fromJson(Map<String, dynamic> json) {
    double parseBorderRadius(dynamic v) {
      if (v == null) return 5.0;
      if (v is num) return v.toDouble();
      if (v is String) {
        final cleaned = v.trim();
        final parsed = double.tryParse(cleaned);
        if (parsed != null) return parsed;
        // tenta remover vírgulas etc
        return double.tryParse(cleaned.replaceAll(',', '.')) ?? 5.0;
      }
      return 5.0;
    }

    return Style(
      id: json['id']?.toString() ?? '',
      colorPrimary: colorFromHex(
        json['color_primary'] as String?,
        fallback: const Color(0xFFF22E52),
      ),
      colorSecondary: colorFromHex(
        json['color_secondary'] as String?,
        fallback: const Color(0xFFFFFFFF),
      ),
      pointShowNumbers:
          json['point_show_numbers'] is bool
              ? json['point_show_numbers'] as bool
              : (json['point_show_numbers'] == 1 ||
                  json['point_show_numbers'] == '1'),
      pointBorderRadius: parseBorderRadius(json['point_border_radius']),
      backgroundUrl: json['background_url'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
    );
  }

  /// Serializa para JSON (chaves no formato do backend).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color_primary': colorToHex(colorPrimary),
      'color_secondary': colorToHex(colorSecondary),
      'point_show_numbers': pointShowNumbers,
      'point_border_radius': pointBorderRadius,
      'background_url': backgroundUrl,
      'title': title,
      'subtitle': subtitle,
    };
  }

  Style copyWith({
    String? id,
    Color? colorPrimary,
    Color? colorSecondary,
    bool? pointShowNumbers,
    double? pointBorderRadius,
    String? pointBackgroundUrl,
    String? backgroundUrl,
    String? title,
    String? subtitle,
  }) {
    return Style(
      id: id ?? this.id,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      colorSecondary: colorSecondary ?? this.colorSecondary,
      pointShowNumbers: pointShowNumbers ?? this.pointShowNumbers,
      pointBorderRadius: pointBorderRadius ?? this.pointBorderRadius,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  String toString() {
    return '''
Style(
  id: $id,
  colorPrimary: ${colorToHex(colorPrimary)},
  colorSecondary: ${colorToHex(colorSecondary)},
  pointShowNumbers: $pointShowNumbers,
  pointBorderRadius: $pointBorderRadius,
  backgroundUrl: $backgroundUrl,
  title: $title,
  subtitle: $subtitle
)
''';
  }

  // ---------- Helpers ----------
  /// Converte string hex para Color. Aceita '#RRGGBB' ou 'RRGGBB'.
  static Color colorFromHex(String? hex, {Color fallback = Colors.white}) {
    if (hex == null) return fallback;
    try {
      var cleaned = hex.replaceAll('#', '').trim();
      if (cleaned.length == 3) {
        // suporte a #RGB expandindo para RRGGBB
        cleaned = cleaned.split('').map((c) => '$c$c').join('');
      }
      if (cleaned.length == 6) {
        cleaned = 'FF$cleaned'; // adiciona alpha se necessário
      } else if (cleaned.length == 8) {
        // ok: AARRGGBB
      } else {
        return fallback;
      }
      final intVal = int.parse(cleaned, radix: 16);
      return Color(intVal);
    } catch (_) {
      return fallback;
    }
  }

  /// Converte Color para '#RRGGBB' (sem alpha).
  static String colorToHex(Color color) {
    final r = color.red.toRadixString(16).padLeft(2, '0');
    final g = color.green.toRadixString(16).padLeft(2, '0');
    final b = color.blue.toRadixString(16).padLeft(2, '0');
    return '#${r.toUpperCase()}${g.toUpperCase()}${b.toUpperCase()}';
  }
}
