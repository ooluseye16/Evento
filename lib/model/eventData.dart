import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'event.dart';
//final eventsBox = Hive.box('events');
final eventListProvider = StateNotifierProvider<EventList>((ref) => EventList([]));

class EventList extends StateNotifier<List<Event>> {
  EventList([List<Event> initialEvents]) : super(initialEvents?? []);

  // List<Event> events = [
  //   Event(
  //       title: 'Christmas Day',
  //       date: DateTime(
  //         2020,
  //         12,
  //         25,
  //       ),
  //       // colors: [
  //       //   Color(0xffFF1744),
  //       //   Color(0xffA60000),
  //       // ],
  //       note:
  //           "'Christmas is not a time nor a season, but a state of mind. To cherish peace and goodwill, to be plenteous in mercy, is to have the real spirit of Christmas.' – Calvin Coolidge"),
  //   Event(
  //     title: 'New Year Day',
  //     date: DateTime(
  //       2021,
  //       01,
  //       01,
  //     ),
  //     // colors: [
  //     //   Color(0xff6253EE).withOpacity(0.75),
  //     //   Color(0xffF4B767).withOpacity(0.75),
  //     // ],
  //   ),
  //   Event(title: 'My Birthday', date: DateTime(2021, 01, 16)),
  //   Event(
  //     title: "Testing",
  //     date: DateTime.now().add(Duration(seconds: 30)),
  //   ),
  // ];

//  void getEvents() {
//       final eventsBox = Hive.box('events');
//     eventsBox.addAll(events);
//     return eventsBox;
//  }
  void addNewEvent(Event event) {
    //Hive.box('events').add(event);
    state = [
      ...state,
      event
    ];
  }

  void updateCard(Event event, int index) {
    Hive.box('events').putAt(index, event);
  }

  void deleteCard(Event eventToDelete) {
    // events.removeWhere((event) => event.title == eventName);
    Hive.box('events').delete(eventToDelete);
    state = state.where((Event event) => event.date != eventToDelete.date).toList();
  }
}
