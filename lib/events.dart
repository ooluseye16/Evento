import 'package:flutter/material.dart';
class EventData extends ChangeNotifier{
  List<Event> events = [
    Event(title: 'Christmas Day', date: DateTime(2020, 12, 25,), colors: [
      Color(0xffFF1744),
      Color(0xffA60000),
    ],
    note: "'Christmas is not a time nor a season, but a state of mind. To cherish peace and goodwill, to be plenteous in mercy, is to have the real spirit of Christmas.' – Calvin Coolidge"
    ),
    Event(
      title: 'New Year Day',
      date: DateTime(2021, 01, 01,),
      colors: [
        Color(0xff6253EE).withOpacity(0.75),
        Color(0xffF4B767).withOpacity(0.75),
      ],
    ),
    Event(title: 'My Birthday', date: DateTime(2021, 01, 16)),
   Event(
      title: "Testing",
      date: DateTime.now().add(Duration(seconds: 30)),
    ),
  ];

  void addNewCard (Event event) {
    events.add(event);
    notifyListeners();
  }
}



class Event {
  final String title;
  final DateTime date;
  final List<Color> colors;
  final Image backgroundImage;
  final String repeat;
  final String note;
 // final Song song;

Event({
  @required this.title,
  @required this.date,
  this.colors,
  this.backgroundImage,
  this.repeat,
  this.note,
}): assert(
  title != null,
date!= null,
  );
}