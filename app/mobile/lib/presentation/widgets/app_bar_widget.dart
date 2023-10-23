import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20, // Customize the font size if needed
        ),
      ),
      centerTitle: true, // Center the title in the middle
      backgroundColor: ColorConstants.primaryColor, // Use the theme's primary color
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
