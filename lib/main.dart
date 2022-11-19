import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"]! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) =>
        meal.id ==
        mealId); // gives the index of that meal which is already marked as fav
    if (existingIndex >= 0) {
      // if we find the element
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      // if we didn't find the element
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        // the first meal which is find with that id is added to _favoriteMeals
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) =>
        meal.id ==
        id); // if any meal id=id then this function will stop after the first element is found.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        cardColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Vollkorn',
      ),
      home: TabsScreen(
        favoriteMeals: _favoriteMeals,
      ),
      routes: {
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        '/meal-detail': (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
            
        '/filters-screen': (ctx) =>
            FiltersScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
      onGenerateRoute: ((settings) {
        // it is the default page which execute when the app crashes or there is a prblm while navigating through diff pages
        return MaterialPageRoute(
          builder: ((context) => CategoriesScreen()),
        );
      }),
    );
  }
}
