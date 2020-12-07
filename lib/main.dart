import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:evento/add_events.dart';
import 'package:evento/events.dart';
import 'package:evento/fullScreen.dart';
import 'package:evento/widgets/countdownCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(ChangeNotifierProvider(create: (_) => EventData(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xffFCA532),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(iconTheme: IconThemeData(color: Colors.white)),
      title: "Evento",
      home: CountdownSystem(),
    );
  }
}

class CountdownSystem extends StatelessWidget {
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
              TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
                return Text(
                  "${getSystemTime()}",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFCA532)),
                );
              }),
              Expanded(
                flex: 1,
                child: Consumer<EventData>(
                  builder: (context, eventData, _) => ListView.builder(
                    itemCount: eventData.events.length,
                    itemBuilder: (context, index) {
                      var countDownDetails = eventData.events[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: InkWell(
                          onLongPress: () {
                             return showDialog<void>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Delete?"),
                                content: Container(
                                  child: Text("Do you want to delete this event?"),
                                ),
                                actions: [
                                  InkWell(
                                    child: Text("No",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                    onTap: () {
                                      Navigator.pop(context);
                                      },
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text("Yes", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                    onTap: () {
                                       Provider.of<EventData>(context, listen: false).deleteCard(countDownDetails.title);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                       eventName: countDownDetails.title,
                            date: countDownDetails.date,
                            colors: countDownDetails.colors,
                            note: countDownDetails.note,
                                    )));
                          },
                          child: CountDownCard(
                            eventName: countDownDetails.title,
                            date: countDownDetails.date,
                            colors: countDownDetails.colors,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
