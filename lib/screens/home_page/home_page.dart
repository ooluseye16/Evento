import 'package:evento/screens/home_page/components/body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import '../../constants.dart';
import '../add_events.dart';

class HomePage extends StatelessWidget {
  final DateTime dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String abbrMonth = DateFormat.MMM().format(dateNow);
    String getSystemTime() {
      var now = new DateTime.now();
      return new DateFormat("hh : mm : ss").format(now);
    }

    return Scaffold(
            floatingActionButton: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEvents(),
                    ));
              },
              child: Container(
                height: 55.0,
                width: 55.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffFCA532),
                          Color(0xffF4526A),
                        ])),
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today: $abbrMonth ${dateNow.day}, ${dateNow.year}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.settings),
                          onPressed: () {},
                        )
                      ],
                    ),
                    TimerBuilder.periodic(Duration(seconds: 1),
                        builder: (context) {
                      return Text(
                        "${getSystemTime()}",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          foreground: Paint()..shader = linearGradient,
                          // color: Color(0xffFCA532)
                        ),
                      );
                    }),
                    Expanded(
                      flex: 1,
                      child: Body(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}


