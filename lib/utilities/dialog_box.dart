import 'package:flutter/material.dart';
import 'package:the_list/utilities/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel
    });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Add new item',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // save button
                  Button(text: "Save", onPressed: onSave),
                  // cancel button
                  Button(text: "Cancel", onPressed: onCancel)
                ],
              ),
            )
          ],
        )
      )
    );
  }
}