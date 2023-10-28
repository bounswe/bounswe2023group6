import 'package:flutter/material.dart';
import 'package:mobile/presentation/pages/lfg_page.dart';
import 'package:mobile/presentation/pages/search_page.dart';
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
    const SearchPage(),
    const GamePage(),
    const LFGPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Wiki"),
          BottomNavigationBarItem(icon: Icon(Icons.group_add), label: "LFG"),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        }
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}