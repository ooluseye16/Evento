import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page/home_page.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({Key key}) : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> fadeIn;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            )));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: fadeIn,
        child: Stack(
          children: [
            Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/hourGlass.png",
                      fit: BoxFit.cover,
                    ))),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xffFCA532).withOpacity(0.64),
                  const Color(0xffF4526A).withOpacity(0.64),
                ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff3B3D45).withOpacity(0.85),
                  const Color(0xff222326).withOpacity(0.85),
                ]),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 300.0,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/Logo.png",
                      height: 150.0,
                      width: 150.0,
                    ),
                    const Text("evento",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            const Align(
                alignment: Alignment(0.0, 0.9),
                child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    )))
          ],
        ),
      ),
    );
  }
}
