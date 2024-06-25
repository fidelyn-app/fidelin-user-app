import 'package:flutter/material.dart';

class Style {
  final String id;
  final Color pointColor;
  final Color backgroundColor;
  final bool pointShowNumbers;
  final double pointBorderRadius;
  final double pointBorderSize;
  final int pointColumnSize;
  final String? pointBackgroundUrl;
  final String? backgroundUrl;
  final String? title;
  final String? subtitle;

  Style({
    required this.id,
    required this.pointColor,
    required this.backgroundColor,
    this.pointShowNumbers = false,
    required this.pointBorderRadius,
    required this.pointBorderSize,
    required this.pointColumnSize,
    this.pointBackgroundUrl,
    this.backgroundUrl,
    this.title,
    this.subtitle,
  });

  @override
  String toString() {
    return '''
    Style(
      id: $id,
      pointColor: $pointColor,
      pointShowNumbers: $pointShowNumbers,
      pointBorderRadius: $pointBorderRadius,
      pointBorderSize: $pointBorderSize,
      pointColumnSize: $pointColumnSize, 
      pointBackgroundUrl: $pointBackgroundUrl, 
      backgroundUrl: $backgroundUrl,
      backgroundColor: $backgroundColor,
      title: $title, 
      subtitle: $subtitle
    )
    ''';
  }
}
