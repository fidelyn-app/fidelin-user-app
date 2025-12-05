import 'dart:math' as math;

import 'package:fidelyn_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelyn_user_app/app/modules/home/presentation/widgets/card/card_back.dart';
import 'package:fidelyn_user_app/app/modules/home/presentation/widgets/card/card_front.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final int index;

  const CardWidget({super.key, required this.index, required this.constraints});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  final HomeController _homeController = Modular.get<HomeController>();

  late UserCard userCard;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    userCard = _homeController.cards[widget.index];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_controller.isAnimating) return;
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidget = widget.constraints.maxWidth / 1.30;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _toggleCard,
      child: SizedBox(
        width: cardWidget,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * math.pi; // 0 -> pi
            final isFront = angle <= (math.pi / 2);

            final transform =
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle);

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child:
                  isFront
                      ? CardFront(userCard: userCard, width: cardWidget)
                      : Transform(
                        transform: Matrix4.identity()..rotateY(math.pi),
                        alignment: Alignment.center,
                        child: CardBack(userCard: userCard, width: cardWidget),
                      ),
            );
          },
        ),
      ),
    );
  }
}
