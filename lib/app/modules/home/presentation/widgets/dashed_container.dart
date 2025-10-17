import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final double borderRadius;

  const DashedBorderContainer({
    super.key,
    required this.width,
    required this.height,
    this.color = const Color(0xFFFFFFFF),
    this.strokeWidth = 3,
    this.dashLength = 10,
    this.dashGap = 5,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashGap: dashGap,
        borderRadius: borderRadius,
      ),
      child: SizedBox(width: width, height: height),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final double borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(borderRadius),
          ),
        );

    final dashPath = _createDashedPath(path, dashLength, dashGap);

    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashLength, double dashGap) {
    final Path path = Path();
    double distance = 0.0;

    for (final PathMetric metric in source.computeMetrics()) {
      while (distance < metric.length) {
        final double nextDashEnd = distance + dashLength;
        path.addPath(
          metric.extractPath(distance, nextDashEnd.clamp(0.0, metric.length)),
          Offset.zero,
        );
        distance = nextDashEnd + dashGap;
      }
      distance = 0.0; // Reset for next segment if any
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
