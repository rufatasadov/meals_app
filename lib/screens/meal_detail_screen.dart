import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    buildSectionTitle(BuildContext context, String title) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
      );
    }

    buildContainer(Widget widget) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: widget,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(ListView.builder(
                itemCount: selectedMeal.ingredients!.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients![index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                })),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                  itemCount: selectedMeal.steps!.length,
                  itemBuilder: (ctx, index) {
                    return Column(children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(
                          selectedMeal.steps![index],
                        ),
                      ),
                      Divider(),
                    ]);
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:   Icon(isFavorite(mealId)? Icons.star:Icons.star_border) ,
        onPressed: () => toggleFavorite(mealId),
        //   onPressed: () {
        //     Navigator.of(context).pop(mealId);
        //   },
      ),
    );
  }
}
