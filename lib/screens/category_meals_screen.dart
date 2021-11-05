import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  bool _initLoadData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_initLoadData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      final catID = routeArgs['id'];
      categoryTitle = routeArgs['title'] as String;
      displayedMeals = widget.availableMeals.where((element) {
        return element.categories!.contains(catID);
      }).toList();

      _initLoadData = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String itemId) {
    setState(() {
      displayedMeals!.removeWhere((element) => element.id == itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            imageUrl: displayedMeals![index].imageUrl,
            title: displayedMeals![index].title,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            removeItem: _removeItem,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
