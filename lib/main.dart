import 'package:flutter/material.dart';

import './models/meal.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
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
  List<Meal> _fevoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFevorite(String mealId) {
    final existingIndex =
        _fevoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _fevoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _fevoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool isMealFevourite(String id) {
    return _fevoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          bodySmall: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          titleSmall: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      routes: {
        '/': (context) => TabsScreen(_fevoriteMeals),
        CategoryMealsScreen.routeName: ((context) =>
            CategoryMealsScreen(_availableMeals)),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFevorite, isMealFevourite),
        FiltersScreen.routeName: ((context) =>
            FiltersScreen(_filters, _setFilters)),
      },
    );
  }
}
