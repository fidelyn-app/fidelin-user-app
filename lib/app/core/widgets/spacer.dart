import 'package:flutter/material.dart';

enum SpaceSize { xs, s, m, l, xl, xxl, xxxl }

class Spacer {
  static const double xs = 2.0;
  static const double s = 4.0;
  static const double m = 8.0;
  static const double l = 16.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  static double fromSize(SpaceSize size) {
    switch (size) {
      case SpaceSize.xs:
        return xs;
      case SpaceSize.s:
        return s;
      case SpaceSize.m:
        return m;
      case SpaceSize.l:
        return l;
      case SpaceSize.xl:
        return xl;
      case SpaceSize.xxl:
        return xxl;
      case SpaceSize.xxxl:
        return xxxl;
    }
  }
}

class SpaceWidget extends StatelessWidget {
  final SpaceSize size;

  const SpaceWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Spacer.fromSize(size));
  }
}
