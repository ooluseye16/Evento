//

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:evento/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    Key key,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime selectedDate;

  Future _selectDayAndTime(BuildContext context) async {
    DateTime _selectedDay = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) => child);

    TimeOfDay _selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_selectedDay != null && _selectedTime != null) {
      setState(() {
        selectedDate = DateTime(
          _selectedDay.year,
          _selectedDay.month,
          _selectedDay.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Add Event",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                foreground: Paint()..shader = linearGradient,
              ),
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          const TitleText(
            text: "Title of Event",
          ),
          SizedBox(
            height: 5.0.h,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Title of Event",
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black38),
              filled: true,
              isDense: true,
              fillColor: Colors.grey[200],
              border: InputBorder.none,
              enabledBorder: outlineBorder,
              focusedBorder: outlineBorder,
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          const TitleText(
            text: "Date of Event",
          ),
          SizedBox(
            height: 5.0.h,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _selectDayAndTime(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "Select Date of Event"
                          : DateFormat("dd-MM-yyyy").format(selectedDate),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black38),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          const TitleText(text: "Background Image"),
          SizedBox(
            height: 5.0.h,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 150.0.h,
              decoration: DottedDecoration(
                shape: Shape.box,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.grey[400],
                        size: 30,
                      ),
                      Text(
                        "Tap to select Image",
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.black38),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          const TitleText(text: "Description"),
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: 150.0.h,
            padding: EdgeInsets.all(5.0.w),
            decoration: DottedDecoration(
              shape: Shape.box,
              // border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black38),
                  hintText: "Write a short note on the event"),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  //stops: [0.7, 1.0],
                  colors: <Color>[
                    Color(0xffFEA831),
                    Color(0xffEE197F),
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Text(
                "Add Event",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
