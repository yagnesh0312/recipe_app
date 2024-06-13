import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/model/data_getx.dart';
import 'package:recipe_app/pages/Home_page.dart';
import 'package:recipe_app/pages/Intro_page.dart';
import 'package:recipe_app/pages/Navigation_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> circleTrasition;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    circleTrasition = Tween<double>(begin: 1, end: 30).animate(_controller);
    Timer(Duration(milliseconds: 2000), () {
      _controller.forward();
    });
    var st = GetStorage();
    String? name = st.read("name");
    var myBuild = PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) =>
          name == null ? IntroPage() : NavigationPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // const begin = Offset(0.0, 1.0);
        // const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
    var cc = Get.put(RecipeController());
    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.pushReplacement(context, myBuild);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CookBook",
            style: TextStyle(
                color: Clr.black, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 20),
          ScaleTransition(
            scale: circleTrasition,
            child: Container(
              height: 40,
              width: 40,
              decoration:
                  BoxDecoration(color: Clr.black, shape: BoxShape.circle),
            ),
          ),
        ],
      )),
    );
  }
}
