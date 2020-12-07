import 'dart:async';
import 'dart:ui';
import 'package:just_audio/just_audio.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:evento/components/timeRemaining.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../events.dart';

class CountDownCard extends StatefulWidget {
  final String eventName;
  final DateTime date;
  final List<Color> colors;

  CountDownCard({this.eventName, this.date, this.colors});

  @override
  _CountDownCardState createState() => _CountDownCardState();
}

final AudioPlayer player = AudioPlayer();
Future<void> setUpPlayer() async {
  var duration = await player.setAsset('assets/audio/scatter.mp3');
  player.play().timeout(Duration(seconds: 60), onTimeout: () => player.stop());
}

playSong() {
  print("Worked");
  setUpPlayer();
}

class _CountDownCardState extends State<CountDownCard> {
  final todayDate = DateTime.now();
  TimeRemaining display;
  int timeRemaining;

  TimeRemaining countdown(BuildContext context) {
    int dif = widget.date.difference(todayDate).inSeconds;
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      if (this.mounted) {
        setState(() {
          if (dif < 0) {
           AndroidAlarmManager.oneShot(Duration(seconds: 1), 0, playSong());
            t.cancel();
            Provider.of<EventData>(context, listen: false).deleteCard(widget.eventName);
          } else if (dif < 60) {
            display = TimeRemaining(
              days: '0',
              hrs: '0',
              mins: '0',
              secs: dif.toString(),
            );
            dif = dif - 1;
          } else if (dif > 60 && dif < 3600) {
            int m = dif ~/ 60;
            int s = dif - (60 * m);
            display = TimeRemaining(
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
            display = TimeRemaining(
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
            display = TimeRemaining(
              days: d.toString(),
              hrs: h.toString(),
              mins: m.toString(),
              secs: s.toString(),
            );
            dif = dif - 1;
          }
        });
      }
    });
    return display;
  }

  String monthInWords() {
    String month = DateFormat.MMMM().format(widget.date);
    return month;
  }

  String dayInWords() {
    String day = DateFormat.EEEE().format(widget.date);
    return day;
  }

  @override
  void initState() {
    super.initState();
    countdown(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xffFCA532),
      Color(0xffF4526A),
    ];
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.colors != null
              ? widget.colors
              : [
                  Color(0xffFCA532),
                  Color(0xffF4526A),
                ],
        ),
      ),
      height: 300.0,
      padding: EdgeInsets.fromLTRB(30.0, 24.0, 24.0, 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.eventName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${dayInWords()} ${widget.date.day} ${monthInWords()} ${widget.date.year}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomArrangement(
                  timeRemaining: display != null ? display.days : '0',
                  inWhat: "DAYS"),
              CustomArrangement(
                timeRemaining: display != null ? display.hrs : '0',
                inWhat: 'HRS',
              ),
              CustomArrangement(
                timeRemaining: display != null ? display.mins : '0',
                inWhat: 'MINS',
              ),
              CustomArrangement(
                timeRemaining: display != null ? display.secs : '0',
                inWhat: 'SECS',
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.share,
                      color:
                          widget.colors != null ? widget.colors[0] : colors[0],
                      size: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Share',
                        style: TextStyle(
                          color: widget.colors != null
                              ? widget.colors[0]
                              : colors[0],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              OutlineButton(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                textColor: Colors.white,
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomArrangement extends StatelessWidget {
  final String timeRemaining;
  final String inWhat;
  CustomArrangement({
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
