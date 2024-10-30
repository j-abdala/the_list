import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:the_list/pages/categories_page.dart';

class TheListCategoryTile extends StatelessWidget {
  final String categoryName;
  final String categoryIcon;
  Function(BuildContext)? deleteFunction;

  TheListCategoryTile({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    required this.deleteFunction,
  });

  Widget checkCategoryIcon(String iconName) {
    switch(iconName) {
      case 'house':
        return Icon(Icons.house);
      case 'shopping_cart':
        return Icon(Icons.shopping_cart);
      case 'shopping_bag_rounded':
        return Icon(Icons.shopping_bag_rounded);
      case 'car_repair':
        return Icon(Icons.car_repair);
      case 'pets':
        return Icon(Icons.pets);
      case 'assignment':
        return Icon(Icons.assignment);
      case 'task':
        return Icon(Icons.task);
      case 'cleaning_services':
        return Icon(Icons.cleaning_services);
      default:
        return Icon(Icons.not_interested);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, bottom: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_forever,
              backgroundColor: Colors.red.shade800,
              borderRadius: BorderRadius.circular(5),)
          ]),
        child: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(categoryName: categoryName))),
          child: Container(
            alignment: Alignment.center,
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (categoryIcon == "not_interested") ...[
                  Text("")
                ] else ...[
                  checkCategoryIcon(categoryIcon)
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}