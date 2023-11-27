import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        automaticallyImplyLeading:
            showBackButton, // Control back button visibility
        title: InkWell(
          onTap: () {
            Phoenix.rebirth(context);
          },
          child: SizedBox(
              height: 150,
              child: Image.asset('lib/assets/logo.png', fit: BoxFit.contain)),
        ),
        centerTitle: true, // Center the title in the middle
        backgroundColor:
            Theme.of(context).primaryColor, // Use the theme's primary color
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
