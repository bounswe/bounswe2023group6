import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';

class SmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SmallButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.buttonColor,
        padding: const EdgeInsets.all(8.0),
        textStyle: const TextStyle(fontSize: 12.0),
      ),
      child: Text(label),
    );
  }
}
