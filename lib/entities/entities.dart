import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Event {
  int id;
  final String title;
  @Property(type: PropertyType.date)
  final DateTime date;
  final String imagePath;
  final String repeat;
  final String note;
  final String song;

  Event({
    this.id = 0,
    @required this.title,
    @required this.date,
    this.imagePath,
    this.repeat,
    this.note,
    this.song,
  });
}
