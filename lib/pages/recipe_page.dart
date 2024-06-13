import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/model/data.dart';
import 'package:recipe_app/model/data_getx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RecipePage extends StatelessWidget {
  final Map<String, String?> data;
  RecipePage({super.key, required this.data});
  int i = 0;
  getImageUrl(String name) {
    return "https://www.themealdb.com/images/ingredients/$name.png";
  }

  var _controller = Get.put(RecipeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: data,
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.4,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data["strMealThumb"] ?? ""),
                    ),
                  ),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white))),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // heading
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                data["strMeal"]!,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data["strTags"] ?? "",
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                data["strArea"]!,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Clr.black.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        GetBuilder<RecipeController>(
                          init: RecipeController(),
                          initState: (_) {},
                          builder: (_) {
                            return GestureDetector(
                              onTap: () {
                                _controller.onFevClick(data["idMeal"]!);
                              },
                              child: Icon(
                                _controller.fevIdList.contains(data["idMeal"]!)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _controller.fevIdList
                                        .contains(data["idMeal"]!)
                                    ? Colors.red
                                    : Colors.grey,
                                size: _controller.fevIdList
                                        .contains(data["idMeal"]!)
                                    ? 35
                                    : 30,
                              ),
                            );
                          },
                        ),
                      ],
                    )

                    // Youtube
                    ,
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        print(data["strYoutube"]!);
                        launchUrlString(data["strYoutube"]!);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Watch Video on Youtube",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Ingredients",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: 150,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 1;
                                  data["strIngredient$i"] != "";
                                  i++)
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: 70,
                                        margin: EdgeInsets.only(top: 50),
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.black54,
                                                  Colors.black.withOpacity(0)
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Colors.black.withOpacity(0.1)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 30),
                                            Text("${data["strIngredient$i"]}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("${data["strMeasure$i"]}",
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 75,
                                        margin: EdgeInsets.only(
                                            // bottom: 10,
                                            ),
                                        child: Image.network(getImageUrl(
                                            data["strIngredient$i"]!)),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )),
                    Text(
                      "Instruction",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(data["strInstructions"]!)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
