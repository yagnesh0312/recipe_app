import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/model/data_getx.dart';
import 'package:recipe_app/pages/recipe_page.dart';

class RecipeTile extends StatelessWidget {
  final Map<String, String?> data;
  RecipeTile({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data["strInstructions"] != null) {
          Get.to(RecipePage(
            data: data,
          ));
        } else {
          var controller = Get.put(RecipeController());
          Get.dialog(Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
          controller.getMealById(data["idMeal"]!).then((v) {
            Get.back();
            Get.to(RecipePage(
              data: v,
            ));
          });
        }
      },
      child: Hero(
        tag: data,
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),

          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(data["strMealThumb"]!)),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  // Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GetBuilder<RecipeController>(
                      init: RecipeController(),
                      initState: (_) {},
                      builder: (_controller) {
                        return GestureDetector(
                          onTap: () {
                            _controller.onFevClick(data["idMeal"]!);
                          },
                          child: Icon(
                            _controller.fevContains(data["idMeal"]!)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _controller.fevContains(data["idMeal"]!)
                                ? Colors.red
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "${data["strMeal"]}",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Clr.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                if (data["strTags"] != null)
                  Text(
                    "${data["strTags"] ?? ""}",
                    style: TextStyle(
                        color: Clr.white.withOpacity(0.8),
                        fontWeight: FontWeight.normal,
                        fontSize: 10),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
