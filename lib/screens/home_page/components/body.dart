import 'package:evento/repository/events_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';
import 'events_listview.dart';

class Body extends ConsumerWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamEvents = ref.watch(eventsProvider);

    return streamEvents.when(
        data: (events) {
          return events.isNotEmpty
              ? EventsListView(
                  events: events,
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You haven’t added any events yet",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.sp,
                          foreground: Paint()..shader = linearGradient,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Add an event you’re excited about.A birthday, a concert or a party ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: const Color(0xff121212)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          //print(error);
          return Text(error);
        });
  }
}
