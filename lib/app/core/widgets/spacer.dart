import 'package:flutter/material.dart';

enum SpaceSize { xs, s, m, l, xl, xxl }

class SpaceWidget extends StatelessWidget {
  final SpaceSize size;

  SpaceWidget({super.key, required this.size});

  final Map<SpaceSize, double> _sizeMap = {
    SpaceSize.xs: 2.0,
    SpaceSize.s: 4.0,
    SpaceSize.m: 8.0,
    SpaceSize.l: 16.0,
    SpaceSize.xl: 32.0,
    SpaceSize.xxl: 64.0,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _sizeMap[size]!,
    );
  }
}
