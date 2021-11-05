import 'package:flutter/material.dart';
import './models/meal.dart';
import './screens/filter_screen.dart';
import './screens/bottom_tab_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutenFree': false,
    'lactoseFree': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealID) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      print(_filters['vegetarian']);
      _filters = filterData!;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (!meal.isGlutenFree! && _filters['glutenFree']!) {
          return false;
        }
        if (!meal.isLactoseFree! && _filters['lactoseFree']!) {
          return false;
        }
        if (!meal.isVegetarian! && _filters['vegetarian']!) {
          return false;
        }
        if (!meal.isVegan! && _filters['vegan']!) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    print('shecking id = $id');
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(50, 91, 91, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => BottomTabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.route_name: (ctx) => FilterScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoiesScreen(), //some page
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => CategoryMealsScreen(_availableMeals));
      },
    );
  }
}
