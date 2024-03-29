import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:evento/entities/entities.dart';

import 'event_countdown.dart';

class EventCardContent extends StatelessWidget {
  const EventCardContent({
    Key key,
    @required this.event,
  }) : super(key: key);
  final Event event;
  String monthInWords() {
    String month = DateFormat.MMMM().format(event.date);
    return month;
  }

  String get dayInWords => DateFormat.EEEE().format(event.date);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30.0, 24.0, 24.0, 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            event.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '$dayInWords ${event.date.day} ${monthInWords()} ${event.date.year}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          EventCountDown(
            eventDate: event.date,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 1.0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                icon: const Icon(
                  Icons.share,
                  color: Color(0xffFCA532),
                  size: 20.0,
                ),
                label: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Share',
                    style: TextStyle(
                      color: Color(0xffFCA532),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
