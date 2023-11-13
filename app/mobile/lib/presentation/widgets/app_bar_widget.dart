import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  List<Widget>? actions;

  CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    List<Widget>? actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        automaticallyImplyLeading:
            showBackButton, // Control back button visibility
        title: SizedBox(
            height: 150,
            child: Image.asset('lib/assets/logo.png', fit: BoxFit.contain)),
        centerTitle: true, // Center the title in the middle
        backgroundColor:
            Theme.of(context).primaryColor, // Use the theme's primary color
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
