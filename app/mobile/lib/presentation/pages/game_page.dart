import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final _gameLinkList = [
    "lib/assets/witcher3.jpeg",
    "lib/assets/lol.jpeg",
    "lib/assets/cod.jpeg",
    "lib/assets/celeste.webp",
    "lib/assets/bg3.avif",
    "lib/assets/ori.jpeg",
  ];

  final _gameNameList = [
    "Witcher 3",
    "League of Legends",
    "Call of Duty: WWII",
    "Celeste",
    "Baldur's Gate 3",
    "Ori and The Will of The Wisps",
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(title: "Game Lounge") ,
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          for (var i = 0; i < 6; i++) GameCard(gameLink: _gameLinkList[i], gameName: _gameNameList[i]),
        ],
      )
    );
  }
}

class GameCard extends StatelessWidget {
  final String gameLink;
  final String gameName;
  const GameCard({
    super.key, required this.gameLink, required this.gameName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(gameLink),
                      fit: BoxFit.cover,
                   ),
                  ),
                ) 
              ),
               Expanded(
                flex: 3,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(gameName),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
     );
  }
}

