import 'dart:async';
import 'dart:ui';
import 'package:evento/components/timeRemaining.dart';
import 'package:evento/widgets/timeleft_and_unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class FullScreen extends StatefulWidget {
  final String eventName;
  final DateTime date;
  final List<Color> colors;
  final String note;
  final String imagePath;

  FullScreen(
      {this.eventName, this.date, this.colors, this.note, this.imagePath});

  @override
  _FullScreenState createState() => _FullScreenState();
}

final AudioPlayer player = AudioPlayer();
Future<void> setUpPlayer() async {
  await player.setAsset('assets/audio/scatter.mp3');
  player.play().timeout(Duration(seconds: 60), onTimeout: () => player.stop());
}

playSong() {
  print("Worked");
  setUpPlayer();
}

class _FullScreenState extends State<FullScreen> {
  final todayDate = DateTime.now();
  TimeRemaining display;
  int timeRemaining;

  TimeRemaining countdown() {
    int dif = widget.date.difference(todayDate).inSeconds;
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      if (this.mounted) {
        setState(() {
          if (dif < 0) {
          } else if (dif < 60) {
            display = TimeRemaining(
              days: '00',
              hrs: '00',
              mins: '00',
              secs: dif.toString(),
            );
            dif = dif - 1;
          } else if (dif > 60 && dif < 3600) {
            int m = dif ~/ 60;
            int s = dif - (60 * m);
            display = TimeRemaining(
              days: '00',
              hrs: '00',
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
              days: '00',
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
    countdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
        padding: EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                    TimeLeftAndUnit(
                        timeRemaining: display != null ? display.days : '00',
                        inWhat: "DAYS"),
                    TimeLeftAndUnit(
                      timeRemaining: display != null ? display.hrs : '00',
                      inWhat: 'HRS',
                    ),
                    TimeLeftAndUnit(
                      timeRemaining: display != null ? display.mins : '00',
                      inWhat: 'MINS',
                    ),
                    TimeLeftAndUnit(
                      timeRemaining: display != null ? display.secs : '00',
                      inWhat: 'SECS',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 1.0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      icon: Icon(
                        Icons.share,
                        color: Color(0xffFCA532),
                        size: 20.0,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Share',
                          style: TextStyle(
                            color: Color(0xffFCA532),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: widget.note != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Note",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          widget.note,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
