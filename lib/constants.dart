import 'package:flutter/material.dart';

List<String> events = [
  'Anniversary',
  'Announcement',
  'Birthday',
  'Concert',
  'Convention',
  'Examination',
  'Flight',
  'Holiday',
  'Movie/TV',
  'Party',
  'Religious',
  'Trip',
  'Others',
];

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color(0xffFEA831),
    Color(0xffEE197F),
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 50.0));