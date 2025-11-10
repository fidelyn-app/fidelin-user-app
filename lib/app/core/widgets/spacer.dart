// lib/core/widgets/spacer.dart
import 'package:flutter/material.dart';

enum SpaceSize { xs, s, m, l, xl, xxl, xxxl }

class AppSpacer {
  const AppSpacer._();

  static double fromSize(SpaceSize size) {
    switch (size) {
      case SpaceSize.xs:
        return 2.0;
      case SpaceSize.s:
        return 4.0;
      case SpaceSize.m:
        return 8.0;
      case SpaceSize.l:
        return 16.0;
      case SpaceSize.xl:
        return 32.0;
      case SpaceSize.xxl:
        return 48.0;
      case SpaceSize.xxxl:
        return 64.0;
    }
  }
}

/// Widget para espaçamento. Por padrão é vertical (height),
/// mas você pode passar axis: Axis.horizontal para usar largura.
class SpaceWidget extends StatelessWidget {
  final SpaceSize size;
  final Axis axis;

  const SpaceWidget({super.key, required this.size, this.axis = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    final value = AppSpacer.fromSize(size);

    return SizedBox(
      height: axis == Axis.vertical ? value : null,
      width: axis == Axis.horizontal ? value : null,
    );
  }
}
