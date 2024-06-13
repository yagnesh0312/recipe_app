import 'package:flutter/material.dart';
import 'package:recipe_app/model/data.dart';
import 'package:recipe_app/pages/category_page.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel c;
  const CategoryTile({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (con) => CategoryPage(c: c)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: NetworkImage(c.strCategoryThumb))),
            ),
            Text("${c.strCategory}"),
          ],
        ),
      ),
    );
  }
}
