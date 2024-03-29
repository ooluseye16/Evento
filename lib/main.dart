//import 'package:android_alarm_manager/android_alarm_manager.dart';
//import 'package:evento/model/eventData.dart';
// import 'package:evento/ui/countdownSystem.dart';
import 'package:evento/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context) {
          return MaterialApp(
            color: const Color(0xffFCA532),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            title: "Evento",
            home: const CustomSplashScreen(),
          );
        });
  }
}
