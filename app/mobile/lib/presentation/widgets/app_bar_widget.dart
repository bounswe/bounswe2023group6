import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        automaticallyImplyLeading: showBackButton, // Control back button visibility
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20, // Customize the font size if needed
          ),
        ),
        centerTitle: true, // Center the title in the middle
        backgroundColor: ColorConstants.primaryColor, // Use the theme's primary color
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

