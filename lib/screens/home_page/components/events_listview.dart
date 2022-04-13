import 'package:evento/entities/entities.dart';
import 'package:evento/repository/events_repository.dart';
import 'package:evento/screens/full_screen.dart';
import 'package:evento/widgets/countdown_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EventsListView extends ConsumerWidget {
   const EventsListView({
    @required this.events,
    Key key,
  }) : super(key: key);
final List<Event> events;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h),
            child: InkWell(
              onLongPress: () {
                return showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete?"),
                        content: const Text(
                            "Do you want to delete this event?"),
                        actions: [
                          InkWell(
                            child: const Text("No",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0.w),
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {
                              ref.read(eventRepositoryProvider).deleteCard(event);
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
                          event: event,
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
