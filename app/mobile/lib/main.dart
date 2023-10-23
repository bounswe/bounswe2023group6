import 'package:flutter/material.dart';
import 'presentation/pages/home_page.dart'; // Import the home_page.dart file
import 'presentation/widgets/app_bar_widget.dart'; // Import the app_bar_widget file
import 'constants/color_constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Lounge',
      theme: ThemeData(
        primaryColor: ColorConstants.primaryColor,
      ),
      // Define the initial route (optional)
      initialRoute: '/',
      // Define the routes for your app
      routes: {
        '/': (context) => const HomePage(), // Home page
      },
      // Set the CustomAppBar as the app bar for all pages
      builder: (context, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Game Lounge'),
          body: child,
        );
      },
    );
  }
}
