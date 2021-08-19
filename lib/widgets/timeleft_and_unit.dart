
import 'package:flutter/material.dart';

class TimeLeftAndUnit extends StatelessWidget {
  final String timeRemaining;
  final String inWhat;
  TimeLeftAndUnit({
    this.timeRemaining,
    this.inWhat,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            timeRemaining != null ? timeRemaining : '00',
            style: TextStyle(
                color: Colors.white,
                fontSize: 38.0,
                fontWeight: FontWeight.w700),
          ),
          Text(
            inWhat,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
