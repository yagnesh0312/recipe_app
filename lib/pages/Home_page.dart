import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_app/components/Recipe_tile.dart';
import 'package:recipe_app/components/Search_btn.dart';
import 'package:recipe_app/components/category_tile.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/model/data.dart';
import 'package:recipe_app/model/data_getx.dart';
import 'package:recipe_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var controller = Get.put(RecipeController());
  GetStorage sg = GetStorage();
  @override
  Widget build(BuildContext context) {
  String name = sg.read("name") ??" ";
    return Scaffold(backgroundColor: Clr.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey, $name ❤️",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Clr.black),
                ),
                Text(
                  "What would you like to cook today?",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Clr.black),
                ),
                SizedBox(height: 10),
                SearchBtn(),
                SizedBox(height: 20),
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: GetBuilder<RecipeController>(
                    init: controller,
                    builder: (_) {
                      // control.searchData("pizza");
                      List c = _.category.value;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: c.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CategoryTile(c: c[index] as CategoryModel),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Populer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                GetX<RecipeController>(
                  init: RecipeController(),
                  builder: (_) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _.recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeTile(data: _.recipes[index]);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
