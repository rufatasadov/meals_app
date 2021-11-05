import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favotiteMeals;
  FavoriteScreen(this.favotiteMeals);

  @override
  Widget build(BuildContext context) {
    if (favotiteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorite meals!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favotiteMeals[index].id,
            imageUrl: favotiteMeals[index].imageUrl,
            title: favotiteMeals[index].title,
            duration: favotiteMeals[index].duration,
            complexity: favotiteMeals[index].complexity,
            affordability: favotiteMeals[index].affordability,
            removeItem: null,
          );
        },
        itemCount: favotiteMeals!.length,
      );
    }
  }
}
