import 'dart:async';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime expiration;
  final TextStyle? style;
  final VoidCallback? onExpired;
  final UserCard userCard;

  const CountdownTimer({
    super.key,
    required this.expiration,
    this.style,
    this.onExpired,
    required this.userCard,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _computeRemaining();
    _startTimer();
  }

  void _computeRemaining() {
    final now = DateTime.now();
    // Se estiver usando UTC, troque por DateTime.now().toUtc()
    final diff = widget.expiration.difference(now);
    setState(() => _remaining = diff.isNegative ? Duration.zero : diff);
  }

  void _startTimer() {
    // cancela timer existente (precaução)
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _computeRemaining();

      if (_remaining == Duration.zero) {
        _timer?.cancel();
        if (widget.onExpired != null) widget.onExpired!();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se a expiration mudou, recalcula e reinicia o timer
    if (!widget.expiration.isAtSameMomentAs(oldWidget.expiration)) {
      _computeRemaining();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    if (d == Duration.zero) return 'Expirado';

    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    final twoDigits = (int n) => n.toString().padLeft(2, '0');

    if (days > 0) {
      return '$days dias ${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadowColor = Colors.black.withAlpha((0.12 * 255).round());

    return Container(
      decoration: BoxDecoration(
        color: widget.userCard.card.style.colorSecondary,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: widget.userCard.card.style.colorPrimary,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _format(_remaining),
        style: TextStyle(
          color: widget.userCard.card.style.colorPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
