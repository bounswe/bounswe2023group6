import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final _gameLinkList = [
    "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png",
    "https://cdn.ntvspor.net/047bed7cbad44a3dae8bdd7b643ab253.jpg?crop=158,0,782,624&w=800&h=800&mode=crop",
    "https://upload.wikimedia.org/wikipedia/tr/8/85/Call_of_Duty_WIII_Kapak_Resmi.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/0/0f/Celeste_box_art_full.png",
    "https://image.api.playstation.com/vulcan/ap/rnd/202302/2321/ba706e54d68d10a0eb6ab7c36cdad9178c58b7fb7bb03d28.png",
    "https://upload.wikimedia.org/wikipedia/en/9/94/Ori_and_the_Will_of_the_Wisps.jpg",
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
                      image: NetworkImage(gameLink),
                      fit: BoxFit.fill,
                    )
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

