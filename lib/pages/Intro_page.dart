import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/components/button.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/pages/Home_page.dart';
import 'package:recipe_app/pages/Navigation_page.dart';
import 'package:recipe_app/pages/select_cat_page.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _form = GlobalKey();

  var name = false.obs;

  var submit = false.obs;

  late AnimationController ani;
  late Animation<double> scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f.requestFocus();
    ani = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    scale = Tween(begin: 1.0, end: 50.0).animate(ani);
    ani.addListener(() {
      if (ani.isCompleted) {
        Get.offAll(SelectCatPage(), transition: Transition.fade);
      }
    });
  }

  FocusNode f = FocusNode();
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                TextField(
                  focusNode: f,
                  textCapitalization: TextCapitalization.sentences,
                  controller: _controller,
                  onChanged: (v) {
                    if (v.trim().isEmpty) {
                      name.value = false;
                    } else {
                      name.value = true;
                    }
                  },
                  style: TextStyle(color: Clr.white),
                  decoration: InputDecoration(
                      label: Text(
                        "Name",
                        style: TextStyle(color: Clr.white),
                      ),
                      focusColor: Clr.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Clr.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Clr.white))),
                ),
                SizedBox(height: 20),
                name.value
                    ? ScaleTransition(
                        scale: scale,
                        child: GestureDetector(
                            onTap: () {
                              submit.value = true;
                              f.unfocus();
                              GetStorage _box = GetStorage();
                              _box.write("name", _controller.text.trim());
                              _box.save().then((v) {
                                ani.forward();
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Set",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                    color:
                                        submit.value ? Clr.white : Clr.black),
                              ),
                            )),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
