import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:recipe_app/components/Recipe_tile.dart';
import 'package:recipe_app/model/color.dart';
import 'package:recipe_app/model/data_getx.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<RecipeController>(
          init: RecipeController(),
          initState: (_) {},
          builder: (_) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              shrinkWrap: true,
              primary: false,
              itemCount: _.fevIdList.length,
              itemBuilder: (context, index) {

                return FutureBuilder(
                    future: _.getMealById(_.fevIdList[index].toString()),
                    builder: (context, snapshot) {
                // print(snapshot.error!);
                      if (snapshot.hasData || snapshot.data != null) {
                        return RecipeTile(data: snapshot.data!);
                      }
                      return Center(child: CircularProgressIndicator());
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
