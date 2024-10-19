import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TheListTile extends StatelessWidget {
  final String itemName;
  final DateTime? dueDate;
  final bool itemCompleted;
  final String categoryName;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TheListTile({
    super.key, 
    required this.itemName, 
    required this.dueDate,
    required this.itemCompleted,
    required this.categoryName, 
    required this.onChanged,
    required this.deleteFunction
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
              borderRadius: BorderRadius.circular(5))
          ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: itemCompleted, 
                onChanged: onChanged,
                checkColor: Theme.of(context).iconTheme.color,
                activeColor: Theme.of(context).colorScheme.secondary,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1
                ),
              ),
              // task name
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        decoration: itemCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        fontSize: 21,
                        fontWeight: FontWeight.w400),
                      children: [
                        if (dueDate == null) ...[
                          TextSpan(text: itemName)
                        ] else ...[
                          TextSpan(text: '$itemName\n'),
                          TextSpan(
                            text: 'Due: ${dueDate.toString().split(" ")[0]}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18
                            )
                          )
                        ]
                        //dueDate == null ? itemName : '$itemName\nDue: ${dueDate.toString().split(" ")[0]}',
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}