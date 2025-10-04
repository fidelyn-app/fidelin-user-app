import 'package:json_annotation/json_annotation.dart';

part 'style_dto.g.dart';

@JsonSerializable()
class StyleDTO {
  final String id;
  final String colorPrimary;
  final String colorSecondary;

  @JsonKey(fromJson: _toBool, toJson: _fromBool)
  final bool pointShowNumbers;

  @JsonKey(fromJson: _toDouble, toJson: _fromDouble)
  final double pointBorderRadius;

  final String? pointBackgroundUrl;
  final String? backgroundUrl;
  final String? title;
  final String? subtitle;

  StyleDTO({
    required this.id,
    required this.colorPrimary,
    required this.colorSecondary,
    this.pointShowNumbers = false,
    this.pointBorderRadius = 5.0,
    this.pointBackgroundUrl,
    this.backgroundUrl,
    this.title,
    this.subtitle,
  });

  factory StyleDTO.fromJson(Map<String, dynamic> json) =>
      _$StyleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StyleDTOToJson(this);

  // ---------- Helpers for (de)serialization ----------

  // Accepts bool, number (1/0) or string ('1', 'true', 'false') and returns bool.
  static bool _toBool(dynamic v) {
    if (v == null) return false;
    if (v is bool) return v;
    if (v is num) return v == 1;
    if (v is String) {
      final s = v.trim().toLowerCase();
      return s == '1' || s == 'true' || s == 'yes';
    }
    return false;
  }

  static dynamic _fromBool(bool v) => v;

  // Accepts num or string and converts to double. Falls back to 5.0 on failure.
  static double _toDouble(dynamic v) {
    if (v == null) return 5.0;
    if (v is num) return v.toDouble();
    if (v is String) {
      final cleaned = v.trim().replaceAll(',', '.');
      final parsed = double.tryParse(cleaned);
      if (parsed != null) return parsed;
      // try removing non-numeric chars
      final digits = RegExp(r'[-0-9.]');
      final filtered =
          cleaned.split('').where((c) => digits.hasMatch(c)).join();
      return double.tryParse(filtered) ?? 5.0;
    }
    return 5.0;
  }

  static dynamic _fromDouble(double v) => v;
}
