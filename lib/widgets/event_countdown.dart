
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:evento/widgets/timeleft_and_unit.dart';

import '../countdown_service.dart';

class EventCountDown extends ConsumerWidget {
  const EventCountDown({
    Key key,
    @required this.eventDate,
  }):super(key: key);

  final DateTime eventDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final display = ref.watch(countDownProvider(eventDate));
    return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
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
