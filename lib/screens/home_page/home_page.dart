import 'package:evento/screens/add_event/add_events.dart';
import 'package:evento/screens/home_page/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  DateTime get todaysDate => DateTime.now();
  String get getSystemTime => DateFormat("hh : mm : ss").format(todaysDate);

  @override
  Widget build(BuildContext context) {
    String abbrMonth = DateFormat.MMM().format(DateTime.now());

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEvents()));
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: (context) => const AddEvent());
        },
        child: Container(
          height: 55.0.w,
          width: 55.0.w,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffFCA532),
                    Color(0xffF4526A),
                  ])),
          child: Icon(
            Icons.add,
            size: 30.0.w,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 15.0.h, 10.0.w, 10.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today: $abbrMonth ${todaysDate.day}, ${todaysDate.year}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  )
                ],
              ),
              TimerBuilder.periodic(const Duration(seconds: 1),
                  builder: (context) {
                return Text(
                  getSystemTime,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                    foreground: Paint()..shader = linearGradient,
                    // color: Color(0xffFCA532)
                  ),
                );
              }),
              const Expanded(
                flex: 1,
                child: Body(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
