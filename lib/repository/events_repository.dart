import 'package:evento/entities/entities.dart';
import 'package:evento/objectbox.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//final eventsBox = Hive.box('events');
final eventListProvider = Provider<EventList>((ref) => EventList(ref.read));

final storeProvider = Provider.autoDispose<Store>((ref) {
  Store _store;
  getApplicationDocumentsDirectory().then((dir) {
    _store = Store(
      getObjectBoxModel(),
      directory: join(dir.path, "objectbox"),
    );
  });
  return _store;
});
final eventsProvider = StreamProvider<List<Event>>((ref) {
  final store = ref.read(storeProvider);
  return store
      .box<Event>()
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());
});

class EventList {
  EventList([this._read]);
  Reader _read;
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
    _read(storeProvider).box<Event>().put(event);
    // state = [...state, event];
  }

  void updateCard(Event event, int index) {
    // Hive.box('events').putAt(index, event);
  }

  void deleteCard(Event eventToDelete) {
    // events.removeWhere((event) => event.title == eventName);
    // Hive.box('events').delete(eventToDelete);
    // state =
    //     state.where((Event event) => event.date != eventToDelete.date).toList();
  }
}
