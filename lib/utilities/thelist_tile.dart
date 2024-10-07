import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TheListTile extends StatelessWidget {
  final String itemName;
  final bool itemCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? archieveFunction;

  TheListTile({
    super.key, 
    required this.itemName, 
    required this.itemCompleted, 
    required this.onChanged,
    required this.archieveFunction
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
              onPressed: archieveFunction,
              icon: Icons.assignment_outlined,
              backgroundColor: Colors.red.shade800,
              borderRadius: BorderRadius.circular(5),)
          ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.amber[900],
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: itemCompleted, 
                onChanged: onChanged,
                activeColor: Colors.grey[600]),
              
              // task name
              Text(
                itemName,
                style: TextStyle(decoration: itemCompleted ? TextDecoration.lineThrough : TextDecoration.none))
            ],
          ),
        ),
      ),
    );
  }
}