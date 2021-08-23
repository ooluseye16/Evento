import 'package:evento/entities/entities.dart';
import 'package:evento/repository/events_repository.dart';
import 'package:evento/screens/fullScreen.dart';
import 'package:evento/widgets/countdownCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsListView extends ConsumerWidget {
   EventsListView({
    @required this.events,
    Key key,
  }) : super(key: key);
final List<Event> events;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
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
                          child: Text(
                              "Do you want to delete this event?"),
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
                              context.read(eventRepositoryProvider).deleteCard(event);
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
                event: event,
              ),
            ),
          );
        },
      );
  }
}
