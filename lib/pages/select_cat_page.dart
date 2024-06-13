import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/model/catList.dart';
import 'package:recipe_app/model/data.dart';
import 'package:recipe_app/model/data_getx.dart';
import 'package:recipe_app/pages/Navigation_page.dart';

class SelectCatPage extends StatefulWidget {
  const SelectCatPage({super.key});

  @override
  State<SelectCatPage> createState() => _SelectCatPageState();
}

class _SelectCatPageState extends State<SelectCatPage>
    with SingleTickerProviderStateMixin {
  late List<Animation<Offset>> ani;
  late AnimationController controller;
  final _c = Get.put(RecipeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  void start() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    ani = List.generate(categoryList.length, (i) {
      return Tween(
              begin: Offset(1 * (10 * i.toDouble() / categoryList.length), 0),
              end: Offset.zero)
          .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Favourite Category"),
      ),
      body: SafeArea(
        child: Container(
          child: GetBuilder<RecipeController>(
            init: RecipeController(),
            builder: (_) {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        padding:
                            EdgeInsets.only(bottom: 30, left: 20, right: 20),
                        itemCount: categoryList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                        itemBuilder: (context, i) {
                          return SlideTransition(
                            position: ani[i],
                            child: GestureDetector(
                              onTap: () {
                                _.onCatListClick(
                                    categoryList[i]["idCategory"]!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: _.catListSelected.contains(
                                            categoryList[i]["idCategory"])
                                        ? Colors.redAccent
                                        : Colors.white,
                                    border: Border.all(color: Colors.black45)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _.catListSelected.contains(
                                            categoryList[i]["idCategory"])
                                        ? Expanded(child: Icon(Icons.check))
                                        : Container(),
                                    Image.network(
                                        categoryList[i]["strCategoryThumb"]!),
                                    Text(
                                      categoryList[i]["strCategory"]!,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  if (_.catListSelected.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        GetStorage _box = GetStorage();
                        _box.write("fevCat", _.catListSelected);
                        _box.save();
                        Get.offAll(NavigationPage(),
                            transition: Transition.downToUp,duration: Duration(milliseconds: 1000));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Apply",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
