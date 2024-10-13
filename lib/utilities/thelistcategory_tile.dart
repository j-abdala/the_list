import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:the_list/pages/categories_page.dart';

class TheListCategoryTile extends StatelessWidget {
  final String categoryName;
  Function(BuildContext)? deleteFunction;

  TheListCategoryTile({
    super.key,
    required this.categoryName,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 20),
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
            child: Text(categoryName),
          ),
        ),
      )
    );
  }
}