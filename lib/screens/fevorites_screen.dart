import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class Fevoritescreen extends StatelessWidget {
  final List<Meal> fevouriteMeals;

  Fevoritescreen(this.fevouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (fevouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no fevourites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: fevouriteMeals[index].id,
            affordability: fevouriteMeals[index].affordability,
            complexity: fevouriteMeals[index].complexity,
            duration: fevouriteMeals[index].duration,
            imageUrl: fevouriteMeals[index].imageUrl,
            title: fevouriteMeals[index].title,
          );
        },
        itemCount: fevouriteMeals.length,
      );
    }
  }
}
