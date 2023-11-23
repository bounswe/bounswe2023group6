import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/pages/game_wiki_page.dart';
import 'package:mobile/presentation/pages/lfg_page.dart';
import 'package:mobile/presentation/pages/forum_page.dart';
import 'package:mobile/presentation/pages/game_page.dart';
import 'package:mobile/presentation/pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ForumPage(),
    GamePage(),
    //GameWikiPage(game: GameService.getGameStatic(3)),
    LFGPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.forum), label: "Forum"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: "Wiki"),
            BottomNavigationBarItem(icon: Icon(Icons.group_add), label: "LFG"),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
