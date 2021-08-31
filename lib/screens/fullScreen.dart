import 'dart:async';
import 'dart:ui';
import 'package:evento/entities/entities.dart';
import 'package:evento/widgets/event_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class FullScreen extends StatelessWidget {
 final Event event;

  FullScreen(
      {this.event});

  final AudioPlayer player = AudioPlayer();
  Future<void> setUpPlayer() async {
    await player.setAsset('assets/audio/scatter.mp3');
    player
        .play()
        .timeout(Duration(seconds: 60), onTimeout: () => player.stop());
  }

  playSong() {
    print("Worked");
    setUpPlayer();
  }

  final todayDate = DateTime.now();

  String monthInWords() {
    String month = DateFormat.MMMM().format(event.date);
    return month;
  }

  String dayInWords() {
    String day = DateFormat.EEEE().format(event.date);
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
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
                  event.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${dayInWords()} ${event.date.day} ${monthInWords()} ${event.date.year}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                EventCountDown(),
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
              child: event.note != null
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
                          event.note,
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
