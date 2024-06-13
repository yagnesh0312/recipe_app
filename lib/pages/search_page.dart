import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/model/data_getx.dart';

import '../components/Recipe_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var controller = Get.put(RecipeController());
  FocusNode f = FocusNode();
  @override
  Widget build(BuildContext context) {
  f.requestFocus();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
        focusNode: f,
          decoration:
              InputDecoration(hintText: "Search", border: InputBorder.none),
          onChanged: (v) {
            controller.searchData(v);
          },
        ),
      ),
      body: GetBuilder<RecipeController>(
        init: RecipeController(),
        builder: (_) {
          List<Map<String, String?>> s = _.searchedRecipes.value;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            shrinkWrap: true,
            primary: false,
            itemCount: s.length,
            itemBuilder: (context, index) {
              return RecipeTile(data: s[index]);
            },
          );
        },
      ),
    );
  }
}
