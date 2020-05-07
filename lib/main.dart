import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.teal,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Berlin Bold",
      ),
      title: "Countdown to Christmas",
      home: ChristmasCountdown(),
    );
  }
}

class ChristmasCountdown extends StatefulWidget {
  @override
  _ChristmasCountdownState createState() => _ChristmasCountdownState();
}

class _ChristmasCountdownState extends State<ChristmasCountdown> {
  final christmasDate = DateTime(2020, 12, 25);
  final todayDate = DateTime.now();
  Widget display;

  Widget countdown() {
    int dif = christmasDate.difference(todayDate).inSeconds;
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (dif < 1) {
          t.cancel();
        } else if (dif < 60) {
          display = TimerDisplay(
            seconds: dif.toString(),
          );
          dif = dif - 1;
        }
        if (dif < 3600) {
          int m = dif ~/ 60;
          int s = dif - (60 * m);
          display = TimerDisplay(
            min: m.toString(),
            seconds: s.toString(),
          );
          dif = dif - 1;
        }
        if (dif < 86400) {
          int h = dif ~/ 3600;
          int t = dif - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          display = TimerDisplay(
            hours: h.toString(),
            min: m.toString(),
            seconds: s.toString(),
          );
          dif = dif - 1;
        } else {
          int d = dif ~/ 86400;
          int t = dif - (86400 * d);
          int h = t ~/ 3600;
          int i = t - (3600 * h);
          int m = i ~/ 60;
          int s = i - (60 * m);
          display = TimerDisplay(
            days: d.toString(),
            hours: h.toString(),
            min: m.toString(),
            seconds: s.toString(),
          );
          dif = dif - 1;
        }
      });
    });
    return display;
  }

  @override
  void initState() {
    super.initState();
    countdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: ColorizeAnimatedTextKit(
          textStyle: TextStyle(
            fontSize: 30.0,
          ),
          text: [
            "Christmas is coming",
            "Countdown to Christmas",
            "It's about to go down",
          ],
          colors: [
            Colors.white,
            Colors.teal,
            Colors.red,
            Colors.white,
          ],
          textAlign: TextAlign.start,
          alignment: AlignmentDirectional.topStart,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 20.0,),
          Center(child: display),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.copyright, color: Colors.white,size: 15.0,),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("Oluseye Obitola", style: TextStyle(color: Colors.white),),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TimerDisplay extends StatelessWidget {
  final String days;
  final String hours;
  final String min;
  final String seconds;

  TimerDisplay({this.hours, this.days, this.min, this.seconds});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CountDownCard(days, "Day(s)"),
        CountDownCard(hours, "Hour(s)"),
        CountDownCard(min, "Minute(s)"),
        CountDownCard(seconds, "Second(s)"),
      ],
    );
  }
}

class CountDownCard extends StatelessWidget {
  final String time;
  final String label;

  CountDownCard(this.time, this.label);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      color: Colors.white,
      child: Container(
        height: 120.0,
        width: 120.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle( color: Colors.black,fontSize: 18.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0), ),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
