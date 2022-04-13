import 'dart:io';

import 'package:evento/entities/entities.dart';
import 'package:evento/repository/events_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import 'components/header.dart';

class AddEvents extends ConsumerStatefulWidget {
  const AddEvents({Key key}) : super(key: key);

  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends ConsumerState<AddEvents> {
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventNoteController = TextEditingController();
  File image;
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  List<Map<String, dynamic>> imageFrom = [
    {
      "title": "Camera",
      "source": ImageSource.camera,
    },
    {
      "title": "From Gallery",
      "source": ImageSource.gallery,
    }
  ];

  String selectedEvent;
  String selectedImageFrom;
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

  DropdownButton dropdown(List<String> listedItem, String selected,
      List<DropdownMenuItem<String>> dropdownItems) {
    try {
      for (String item in listedItem) {
        var newItem = DropdownMenuItem(
          child: Text(item),
          value: item,
        );
        dropdownItems.add(newItem);
      }
    } catch (e) {
     // print(e);
    }
    return DropdownButton<String>(
      underline: const SizedBox.shrink(),
      value: selected,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          if (selected == selectedEvent) {
            selectedEvent = value;
          } else {
            selectedImageFrom = value;
          }
        });
      },
    );
  }

  DropdownButton imageSource() {
    List<DropdownMenuItem> imageDropdownItems = [];
    try {
      for (var item in imageFrom) {
        var newItem = DropdownMenuItem(
          child: Text(item["title"]),
          value: item,
          onTap: () {
            getImage(item["source"]);
          },
        );
        imageDropdownItems.add(newItem);
      }
    } catch (e) {
     // print(e);
    }
    return DropdownButton(
      underline: const SizedBox.shrink(),
      value: selectedImageFrom,
      items: imageDropdownItems,
      onChanged: (value) {
        setState(() {
          selectedImageFrom = value;
        });
      },
    );
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //var eventData = Provider.of<EventData>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Header(),
            Container(
                height: MediaQuery.of(context).size.height / 1.4,
                padding: EdgeInsets.all(10.0.w),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: TextField(
                        controller: eventTitleController,
                        onChanged: (value) {
                          ref.watch(eventTitleProvider.state).state = value;
                        },
                        decoration: const InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const CustomDivider(),
                    ListTile(
                      leading: const Icon(Icons.celebration),
                      title: const Text("Event"),
                      trailing: dropdown(eventType, selectedEvent, []),
                    ),
                    const CustomDivider(),
                    ListTile(
                        leading: const Icon(Icons.event),
                        title: const Text("Date"),
                        trailing: InkWell(
                          onTap: () {
                            _selectDayAndTime(context);
                          },
                          child: selectedDate != null
                              ? Text("${selectedDate.toLocal()}".split(' ')[0])
                              : const Text("SELECT DATE"),
                        )),
                    const CustomDivider(),
                    ListTile(
                      leading: const Icon(Icons.repeat_rounded),
                      title: const Text("Repeat"),
                      trailing:
                          InkWell(child: const Text("ADD REPEAT"), onTap: () {}),
                    ),
                    const CustomDivider(),
                    ListTile(
                      leading: const Icon(Icons.add_a_photo),
                      title: const Text("Photo"),
                      trailing: imageSource(),
                    ),
                    const CustomDivider(),
                    ListTile(
                      leading: const Icon(Icons.audiotrack_rounded),
                      title: const Text("Song"),
                      trailing: InkWell(child: const Text("ADD SONG"), onTap: () {}),
                    ),
                    const CustomDivider(),
                    ListTile(
                      leading: const Icon(Icons.note),
                      title: const Text("Note"),
                      trailing: InkWell(
                          child: eventNoteController.text.isEmpty
                              ? const Text("ADD NOTE")
                              : const Text("NOTE ADDED"),
                          onTap: () {
                            return showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      InkWell(
                                        child: const Text("Cancel",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        onTap: () {
                                          eventNoteController.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      InkWell(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0.w),
                                          child: const Text(
                                            "Ok",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text("Note added!"),
                                          ));
                                        },
                                      )
                                    ],
                                    title: const Text("Note"),
                                    contentPadding: const EdgeInsets.all(10.0),
                                    content: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      height: 200.0.h,
                                      // width: 100.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: TextField(
                                        controller: eventNoteController,
                                        maxLines: null,
                                        // onChanged: (value) {
                                        //   setState(() {
                                        //     eventNote = value;
                                        //   });
                                        // },
                                        decoration: const InputDecoration(
                                          hintText: "Note",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Consumer(builder: (context, watch, child) {
                          return ElevatedButton(
                            onPressed: () {
                              if (eventTitleController.text != null &&
                                  selectedDate != null) {
                                ref.watch(eventRepositoryProvider)
                                    .addNewEvent(Event(
                                  title: eventTitleController.text,
                                  date: selectedDate,
                                  note: eventNoteController.text,
                                  imagePath: image.path,
                                ));
                                // eventData.addNewCard(Event(
                                //   title: eventTitle,
                                //   date: selectedDate,
                                //   note: eventNote,
                                //   imagePath: image.path,
                                // ));
                              }
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "ADD EVENT",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffFCA532),
                            ),
                          );
                        }))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1.0,
        margin: const EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
      ),
    );
  }
}
