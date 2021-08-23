import 'dart:io';
import 'dart:ui';
import 'package:evento/entities/entities.dart';
import 'package:evento/widgets/event_card_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CountDownCard extends StatelessWidget {
  CountDownCard(
      {this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    // final List<Color> colors = [
    //   Color(0xffFCA532),
    //   Color(0xffF4526A),
    // ];
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(
            File(event.imagePath),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          BackgroundGradient(),
         EventCardContent(event: event,)
        ],
      ),
    );
  }
}



class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFCA532).withOpacity(0.4),
              Color(0xffF4526A).withOpacity(0.4),
            ],
          ),
        ),
      ),
    );
  }
}
