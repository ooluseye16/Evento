
import 'package:evento/widgets/timeleft_and_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../countdown_service.dart';

class EventCountDown extends ConsumerWidget {
  const EventCountDown({this.eventDate});

  final DateTime eventDate;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final display = watch(countDownProvider(eventDate));
    return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TimeLeftAndUnit(
                    timeRemaining: display != null ? display.days : '0',
                    inWhat: "DAYS"),
                TimeLeftAndUnit(
                  timeRemaining: display != null ? display.hrs : '0',
                  inWhat: 'HRS',
                ),
                TimeLeftAndUnit(
                  timeRemaining: display != null ? display.mins : '0',
                  inWhat: 'MINS',
                ),
                TimeLeftAndUnit(
                  timeRemaining: display != null ? display.secs : '0',
                  inWhat: 'SECS',
                ),
              ],
            ),
    );
  }
}
