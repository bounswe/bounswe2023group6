import 'package:flutter/material.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/registration_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/widgets/app_bar_widget.dart';
import 'constants/color_constants.dart';
import 'constants/text_constants.dart';

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
        '/registration': (context) => RegistrationPage(),
        '/login': (context) => LoginPage(),
      },
      // Set the CustomAppBar as the app bar for all pages
      builder: (context, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: TextConstants.titleText),
          body: child,
        );
      },
    );
  }
}
