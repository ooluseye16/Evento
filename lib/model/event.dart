import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class Event {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  final String repeat;
  @HiveField(4)
  final String note;
  @HiveField(5)
  final String song;

  Event({
    @required this.title,
    @required this.date,
   // this.colors,
    this.imagePath,
    this.repeat,
    this.note,
    this.song,
  });
}
