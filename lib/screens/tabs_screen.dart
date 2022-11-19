import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key, required this.favoriteMeals}) : super(key: key);

  final List<Meal> favoriteMeals;
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;

  int selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': 'Your Favorite'
      }, // We can use the widget property in the build method or in initState but can't use here when we initialize the property
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[selectedPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Favourites'),
          ],
        ));
  }
}



// -------------or------------ 
// DefaultTabController(
//         length: 2,
//         // initialIndex: 1,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Meals'),
//             bottom: TabBar(tabs: [
//               Tab(
//                 icon: Icon(Icons.category),
//                 text: 'Categories',
//               ),
//               Tab(
//                 icon: Icon(Icons.star),
//                 text: 'Favourites',
//               ),
//             ]),
//           ),
//           body: TabBarView(children: [CategoriesScreen(), FavoriteScreen()]),
//         ));


