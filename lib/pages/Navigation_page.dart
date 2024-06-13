import 'package:flutter/material.dart';
import 'package:recipe_app/pages/Home_page.dart';
import 'package:recipe_app/pages/bookmark.dart';
import 'package:recipe_app/pages/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  var pages = [HomePage(), BookmarkPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: pages,
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(Icons.bookmark_border_outlined),
              text: "Favorite",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
