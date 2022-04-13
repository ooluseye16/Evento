import 'package:evento/entities/entities.dart';
import 'package:evento/objectbox.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//final eventsBox = Hive.box('events');
final eventRepositoryProvider =
    Provider<EventRepository>((ref) => EventRepository(ref.read));

final storeProvider = FutureProvider<Store>((ref) async {
  Store _store = await getApplicationDocumentsDirectory().then((dir) {
    
    return Store(
      getObjectBoxModel(),
      directory: join(dir.path, "objectbox"),
    );
  });
  return _store;
});
final currentDateProvider = Provider((_) => DateTime.now());
final eventsProvider = StreamProvider<List<Event>>((ref) {
  final storeFuture = ref.watch(storeProvider);
  //final date = ref.watch(currentDateProvider);
  return storeFuture.when(data: (store) {
   
    return store.box<Event>().query().watch(triggerImmediately: true).map(
          (query) => query.find()
            ..removeWhere(
                (event) => event.date.difference(DateTime.now()).inSeconds <= 0)
            ..sort(
              (a, b) => a.date.compareTo(b.date),
            ),
        );
  }, loading: () {
  
    return Stream.value([]);
  }, error: (e, s) {

    return Stream.error(e, s);
  });
});

class EventRepository {
  EventRepository([this._read]);
  final Reader _read;

  void addNewEvent(Event event) {
    _read(storeProvider).whenData((store) => store.box<Event>().put(event));
  }

  void updateCard(Event event, int index) {
    // Hive.box('events').putAt(index, event);
  }

  void deleteCard(Event eventToDelete) {
    _read(storeProvider)
        .whenData((store) => store.box<Event>().remove(eventToDelete.id));
  }
}
