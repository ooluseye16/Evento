import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventTitleProvider = StateProvider.autoDispose<String>((ref) => null);

class Header extends ConsumerWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String eventTitle = watch(eventTitleProvider).state;
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height / 1.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFCA532),
            Color(0xffF4526A),
          ],
          stops: [
            0.02,
            1.0,
          ],
        ),
      ),
      padding: EdgeInsets.fromLTRB(18.0, 25.0, 20.0, 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Row(
                children: [
                  Stack(
                    children: [
                      IconButton(
                          icon: Icon(Icons.calendar_today), onPressed: () {}),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: IconButton(
                            icon: Icon(Icons.add, size: 15.0),
                            onPressed: () {}),
                      ),
                    ],
                  ),
                  InkWell(child: Icon(Icons.more_vert_rounded), onTap: () {}),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
                eventTitle == null || eventTitle.isEmpty
                    ? "New Event"
                    : eventTitle,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Add an upcoming event",
              style: TextStyle(
                  color: Color(0xffFAFAFA),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
