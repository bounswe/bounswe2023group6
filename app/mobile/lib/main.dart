import 'package:flutter/material.dart';
import 'package:mobile/presentation/pages/forgot_password_page.dart';
import 'package:mobile/presentation/pages/game_wiki_page.dart';
import 'package:mobile/presentation/pages/main_screen.dart';
import 'package:mobile/presentation/pages/opening_page.dart';
import 'package:mobile/presentation/pages/post/post_create_page.dart';
import 'package:mobile/presentation/pages/post/post_page.dart';
import 'package:mobile/presentation/pages/profile_page.dart';
import 'package:mobile/utils/shared_manager.dart';
import 'presentation/pages/auth_page_demo.dart';
import 'presentation/pages/registration_page.dart';
import 'presentation/pages/login_page.dart';
import 'constants/color_constants.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Future<void> initiliazeAll() async {
  await SharedManager().initializePreferences();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initiliazeAll();
  runApp(Phoenix(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final _color1 = ColorConstants.color1;
  final _color2 = const Color.fromRGBO(255, 244, 224, 1);
  final _color3 = const Color.fromRGBO(77, 77, 77, 1);
  final _color4 = const Color.fromRGBO(255, 191, 155, 1);
  final _color5 = const Color.fromRGBO(254, 252, 243, 1);
  final _color6 = const Color.fromRGBO(55, 65, 81, 1);
  final darkgray = const Color.fromRGBO(30, 41, 59, 1);
  final gray = const Color.fromRGBO(97, 103, 110, 1);
  final lightgray = const Color.fromRGBO(209, 213, 219, 1);
  final lightgray2 = const Color.fromRGBO(229, 231, 235, 1);
  final cyan = const Color.fromRGBO(87, 149, 172, 1);
  final background = const Color.fromRGBO(243, 244, 246, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Lounge',
      theme: ThemeData(
        primaryColor: darkgray,
        primaryColorLight: _color2,
        primaryColorDark: _color3,
        focusColor: _color4,
        primaryIconTheme:
            IconThemeData(color: Theme.of(context).primaryColorLight),
        iconTheme: IconThemeData(color: _color1),
        scaffoldBackgroundColor: background,
        cardColor: lightgray2,
        textTheme: TextTheme(bodyMedium: TextStyle(color: _color3)),
        drawerTheme: DrawerThemeData(
          backgroundColor: _color5,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkgray,
          unselectedItemColor: _color4,
          selectedLabelStyle: TextStyle(color: _color1),
          selectedIconTheme: IconThemeData(color: _color2),
          selectedItemColor: _color2,
        ),
      ),
      // Define the initial route (optional)
      initialRoute: '/opening',
      // Define the routes for your app
      routes: {
        '/opening': (context) =>  OpeningPage(),
        '/': (context) => const MainScreen(), // Home page
        '/auth': (context) => const AuthPageDemo(),
        '/registration': (context) => RegistrationPage(),
        '/login': (context) => LoginPage(),
        '/forgot': (context) => ForgotPage(),
        //'/profile': (context) => const ProfilePage(),
        //'/post': (context) => PostPage(),
        //'/create_post': (context) => const PostCreatePage(),
        //'/game':(context) => const GameWiki()
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
