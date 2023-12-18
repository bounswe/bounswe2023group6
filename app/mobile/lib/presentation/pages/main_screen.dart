import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/object_keys.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/pages/game_wiki_page.dart';
import 'package:mobile/presentation/pages/lfg_page.dart';
import 'package:mobile/presentation/pages/forum_page.dart';
import 'package:mobile/presentation/pages/game_page.dart';
import 'package:mobile/presentation/pages/home_page.dart';
import 'package:mobile/presentation/pages/navigator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalStaticKeys.homeNavigatorKey,
    GlobalStaticKeys.forumNavigatorKey,
    GlobalStaticKeys.gameNavigatorKey,
    GlobalStaticKeys.lfgNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex]
          .currentState
          ?.pop(_navigatorKeys[_selectedIndex].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    return Future.value(false);
  }

  final List<Widget> navigators = <Widget>[
    CustomNavigator(defaultKey: GlobalStaticKeys.homeNavigatorKey, defaultPage: const HomePage(),),
    CustomNavigator(defaultKey: GlobalStaticKeys.forumNavigatorKey, defaultPage: const ForumPage(),),
    CustomNavigator(defaultKey: GlobalStaticKeys.gameNavigatorKey, defaultPage: GamePage(),),
    CustomNavigator(defaultKey: GlobalStaticKeys.lfgNavigatorKey, defaultPage: LFGPage(),),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.forum), label: "Forum"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: "Games"),
              BottomNavigationBarItem(icon: Icon(Icons.group_add), label: "Groups"),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            }),
        //body: _widgetOptions.elementAt(_selectedIndex),
        body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _selectedIndex,
              children: navigators,
            ),
        )
      ),
    );
  }
}