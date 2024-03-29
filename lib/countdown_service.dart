import 'dart:async';

import 'package:evento/components/timeRemaining.dart';
import 'package:evento/repository/events_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entities/entities.dart';

final eventDateProvider = Provider<DateTime>((ref) => DateTime(2021, 08, 21));

final countDownProvider = StateNotifierProvider.family<CountDown, TimeRemaining, DateTime>((ref, date) {
  return CountDown(date, ref.read);
});

class CountDown extends StateNotifier<TimeRemaining> {

  Reader _read;
  CountDown(this.eventDate, [this._read]): super(TimeRemaining()){
    int dif =  eventDate.difference(DateTime.now()).inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (dif < 0) {
        // Provider.of<EventData>(context, listen: false)
        //     .deleteCard(widget.id);
        // AndroidAlarmManager.oneShotAt(widget.date, 1, playSong(),
        //     wakeup: true);
        timer.cancel();
      } else if (dif < 60) {
        state = TimeRemaining(
          days: '0',
          hrs: '0',
          mins: '0',
          secs: dif.toString(),
        );
        dif = dif - 1;
      } else if (dif > 60 && dif < 3600) {
        int m = dif ~/ 60;
        int s = dif - (60 * m);
        state = TimeRemaining(
          days: '0',
          hrs: '0',
          mins: m.toString(),
          secs: s.toString(),
        );
        dif = dif - 1;
      } else if (dif > 3600 && dif < 86400) {
        int h = dif ~/ 3600;
        int t = dif - (3600 * h);
        int m = t ~/ 60;
        int s = t - (60 * m);
        state = TimeRemaining(
          days: '0',
          hrs: h.toString(),
          mins: m.toString(),
          secs: s.toString(),
        );
        dif = dif - 1;
      } else {
        int d = dif ~/ 86400;
        int t = dif - (86400 * d);
        int h = t ~/ 3600;
        int i = t - (3600 * h);
        int m = i ~/ 60;
        int s = i - (60 * m);
        state = TimeRemaining(
          days: d.toString(),
          hrs: h.toString(),
          mins: m.toString(),
          secs: s.toString(),
        );
        dif = dif - 1;
      }
    });
  }
 Timer _timer;
DateTime eventDate;

@override
  void dispose() {
   _timer.cancel();
    super.dispose();
  }
}