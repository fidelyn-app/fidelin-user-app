import 'package:flutter/material.dart';

class PointWidget extends StatelessWidget {
  final bool selected;
  final bool isLastPoint;
  final Color color;
  final int index;

  const PointWidget({
    super.key,
    this.selected = false,
    this.color = Colors.black,
    this.isLastPoint = false,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: color,
          width: !isLastPoint ? 2.0 : 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child:
          selected
              ? Container(
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              )
              : Center(
                child: Text(
                  '$index',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
    );
  }
}
