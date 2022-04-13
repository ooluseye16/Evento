
import 'package:flutter/material.dart';

class TimeLeftAndUnit extends StatelessWidget {
  final String timeRemaining;
  final String inWhat;
  const TimeLeftAndUnit({
    this.timeRemaining,
    this.inWhat,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          timeRemaining ?? '00',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 38.0,
              fontWeight: FontWeight.w700),
        ),
        Text(
          inWhat,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
