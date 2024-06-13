import 'package:flutter/material.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/pages/search_page.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Clr.black),
            color: Clr.white,
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Search",
              style: TextStyle(color: Clr.black),
            ),
            Icon(
              Icons.search,
              color: Clr.black,
            )
          ],
        ),
      ),
    );
  }
}
