import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const Button({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(12.0),
        textStyle: const TextStyle(fontSize: 18.0),
      ),
      child: Text(label),
    );
  }
}
