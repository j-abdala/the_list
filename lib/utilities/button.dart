import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.text,
    required this.onPressed
    });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        text, 
        style: Theme.of(context).textTheme.bodyMedium)
      );
  }
}