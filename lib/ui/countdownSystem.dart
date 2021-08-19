import 'package:evento/widgets/countdownCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import '../constants.dart';
import '../model/event.dart';
import '../model/eventData.dart';
import 'add_events.dart';
import 'fullScreen.dart';

class CountdownSystem extends StatelessWidget {
  final DateTime dateNow = DateTime.now();


  @override
  Widget build(BuildContext context) {
    String abbrMonth = DateFormat.MMM().format(dateNow);
    String getSystemTime() {
      var now = new DateTime.now();
      return new DateFormat("hh : mm : ss").format(now);
    }
    return FutureBuilder(
        future: Hive.openBox('events'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
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
                      foreground: Paint()..shader = linearGradient,
                     // color: Color(0xffFCA532)
                     ),
                );
              }),
              Expanded(
                flex: 1,
                child: EventCardListView(),
              ),
            ],
          ),
        ),
      ),
    );
          } else
            return Scaffold();
        });

    
  }
}

class EventCardListView extends ConsumerWidget {
  const EventCardListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final eventList = watch(eventListProvider.state);
  //  final eventsBox = Hive.box('events');
    // for (Event event in eventData.events) {
    //   bool found =
    //       eventsBox.values.any((element) => element.date == event.date);
    //   if (!found) {
    //     eventsBox.add(event);
    //   } else {

    //   }
    // }
    // eventsBox.addAll(eventData.events);
    return eventList.isNotEmpty
        ? ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              Event event = eventList[index];
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
                                child: Text("No",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Provider.of<EventData>(context, listen: false)
                                  //     .deleteCard(index);
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
                                  // eventName: countDownDetails.title,
                                  // date: countDownDetails.date,
                                  //  imagePath: countDownDetails.imagePath,
                                  // //  colors: countDownDetails.colors,
                                  // note: countDownDetails.note,
                                )));
                  },
                  child: CountDownCard(
                   event:event ,
                  ),
                ),
              );
            },
          )
        : Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You haven’t added any events yet", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24.0, foreground: Paint()..shader = linearGradient,), textAlign: TextAlign.center,),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text("Add an event you’re excited about.A birthday, a concert or a party ", style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18.0, color: Color(0xff121212)), textAlign: TextAlign.center,),
                ),
              ],
            ),
          );
  }
}
