import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:recipe_app/components/Recipe_tile.dart';
import 'package:recipe_app/model/data.dart';
import 'package:recipe_app/model/data_getx.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel c;
  const CategoryPage({super.key, required this.c});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.c.strCategory),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<RecipeController>(
          init: RecipeController(),
          builder: (_) {
            return FutureBuilder(
              future: _.getMealsByCategory(widget.c),
              builder: (_, s) {
                if (s.hasError) {
                  return Center(
                    child: Text(s.error.toString()),
                  );
                }
                if (!s.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: s.data!.length,
                  itemBuilder: (context, index) {
                    return RecipeTile(data: s.data![index]);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
