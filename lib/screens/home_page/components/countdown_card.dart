import 'dart:io';
import 'package:evento/entities/entities.dart';
import 'package:evento/widgets/event_card_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CountDownCard extends StatelessWidget {
  const CountDownCard(
      {Key key, this.event}) : super(key: key);
  final Event event;

  @override
  Widget build(BuildContext context) {
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
          const BackgroundGradient(),
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
              const Color(0xffFCA532).withOpacity(0.4),
              const Color(0xffF4526A).withOpacity(0.4),
            ],
          ),
        ),
      ),
    );
  }
}
