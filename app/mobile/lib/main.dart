import 'package:flutter/material.dart';
import 'package:mobile/presentation/pages/forgot_password_page.dart';
import 'package:mobile/presentation/pages/main_screen.dart';
import 'package:mobile/presentation/pages/post_page.dart';
import 'package:mobile/presentation/pages/profile_page.dart';
import 'presentation/pages/auth_page_demo.dart';
import 'presentation/pages/registration_page.dart';
import 'presentation/pages/login_page.dart';
import 'constants/color_constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final _color1 = ColorConstants.color1;
  final _color2 = const Color.fromRGBO(255, 244, 224, 1);
  final _color3 = const Color.fromRGBO(77, 77, 77, 1);
  final _color4 = const Color.fromRGBO(255, 191, 155, 1);
  final _color5 = const Color.fromRGBO(254, 252, 243, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Lounge',
      theme: ThemeData(
        primaryColor: _color1,
        primaryColorLight: _color2,
        primaryColorDark: _color3,
        focusColor: _color4,
        primaryIconTheme:
            IconThemeData(color: Theme.of(context).primaryColorLight),
        iconTheme: IconThemeData(color: _color1),
        scaffoldBackgroundColor: _color5,
        cardColor: _color5,
        textTheme: TextTheme(bodyMedium: TextStyle(color: _color3)),
        drawerTheme: DrawerThemeData(
          backgroundColor: _color5,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: _color1,
          unselectedItemColor: _color4,
          selectedLabelStyle: TextStyle(color: _color1),
          selectedIconTheme: IconThemeData(color: _color2),
          selectedItemColor: _color2,
        ),
      ),
      // Define the initial route (optional)
      initialRoute: '/',
      // Define the routes for your app
      routes: {
        '/': (context) => const MainScreen(), // Home page
        '/auth': (context) => const AuthPageDemo(),
        '/registration': (context) => RegistrationPage(),
        '/login': (context) => LoginPage(),
        '/forgot': (context) => ForgotPage(),
        '/profile': (context) => const ProfilePage(),
        '/post': (context) => const PostPage(),
      },
      // Set the CustomAppBar as the app bar for all pages
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
