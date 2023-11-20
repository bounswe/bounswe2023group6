import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/markdown_widget.dart';


class GameWikiPage extends StatelessWidget {
  GameWikiPage({super.key});

  final String content = """ 
# Celeste

## Overview

**Celeste** is a critically acclaimed indie platformer video game developed by Maddy Makes Games. Released in 2018, the game has gained widespread recognition for its challenging gameplay, beautiful pixel art, and a heartfelt narrative.

## Gameplay

### Controls

Players control the protagonist, Madeline, as she ascends the titular mountain, Celeste. The controls are simple yet precise, allowing for tight maneuvers and challenging platforming sequences.

### Platforming Challenges

Celeste is known for its challenging platforming levels, each filled with obstacles, puzzles, and enemies. The game introduces various mechanics, including climbing, dashing, and wall jumping, which players must master to progress through the levels.

### Story

The narrative of Celeste follows Madeline's journey to the summit of Celeste Mountain. Along the way, she encounters other characters and faces her inner struggles. The game delves into themes of mental health, self-discovery, and perseverance.

## Development

### Developer

- **Developer:** Maddy Makes Games
- **Release Date:** January 25, 2018
- **Platforms:** Microsoft Windows, macOS, Linux, Nintendo Switch, PlayStation 4, Xbox One

### Reception

Celeste received widespread acclaim from both players and critics. Its engaging gameplay, emotionally resonant story, and beautiful soundtrack contributed to its success. The game won several awards, including the "Best Independent Game" at The Game Awards 2018.

## Legacy

Celeste has left a lasting impact on the indie gaming scene, inspiring other developers to create emotionally driven and challenging experiences. The game's success also led to the creation of free additional levels, expanding the content available to players.

## External Links

- [Official Celeste Website](https://www.celestegame.com/)
- [Celeste on Steam](https://store.steampowered.com/app/504230/Celeste/)

*Note: The information in this wiki page is based on knowledge as of the last update in January 2022, and there may have been additional developments or releases since then.*

  """;

  final List<Game> itemList =  [
      Game(
          id: 1,
          description:
              "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
          name: "Witcher 3",
          imageLink:
              "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"),
      Game(
          id: 2,
          description:
              "League of Legends (kısaca LoL), Riot Games tarafından geliştirilen ve yayımlanan video oyunu. Microsoft Windows ve macOS işletim sistemlerinde çalışan oyun, tür olarak MOBA (Çok Oyunculu Çevrimiçi Savaş Arenası) olarak adlandırılmaktadır. 27 Ekim 2009'da piyasaya sürülen oyun, 2012 yılında en çok oynanan oyun unvanını aldı. 2014 yılında 67 milyon, 2016 yılında 100 milyon oyuncuya ulaştı. 2020 yılında 115 milyon oyuncuya ulaştı.",
          name: "League of Legends",
          imageLink:
              "https://cdn.ntvspor.net/047bed7cbad44a3dae8bdd7b643ab253.jpg?crop=158,0,782,624&w=800&h=800&mode=crop"),
      Game(
          id: 3,
          description:
              "Call of Duty: WWII, Sledgehammer Games tarafından geliştirilen ve Activision tarafından yayımlanan birinci şahıs nişancı türündeki video oyunudur. Oyun, Call of Duty serisinin 14. oyunu olup 3 Kasım 2017 tarihinde Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürüldü.",
          name: "Call of Duty: WWII",
          imageLink:
              "https://upload.wikimedia.org/wikipedia/tr/8/85/Call_of_Duty_WIII_Kapak_Resmi.jpg"),
      Game(
          id: 4,
          description:
              "Celeste, Kanadalı video oyunu geliştiricisi Matt Thorson tarafından tasarlanan ve geliştirilen bir platform oyunudur. Noel Berry tarafından tasarlanan ve geliştirilen bir platform oyunu olan TowerFall'ın yaratıcısı Matt Thorson tarafından tasarlanan ve geliştirilen bir platform oyunudur. Oyun, 2018'de Microsoft Windows, Nintendo Switch, PlayStation 4, Xbox One, macOS ve Linux için piyasaya sürüldü. Oyun, 2019'da Google Stadia için piyasaya sürüldü.",
          name: "Celeste",
          imageLink:
              "https://upload.wikimedia.org/wikipedia/commons/0/0f/Celeste_box_art_full.png"),
      Game(
          id: 5,
          description:
              "Baldur's Gate 3, Larian Studios tarafından geliştirilen ve Wizards of the Coast tarafından yayınlanan bir rol yapma video oyunudur. Oyun, Dungeons & Dragons 5th edition kurallarına dayanmaktadır. Oyun, 6 Ekim 2020'de Microsoft Windows ve Google Stadia için erken erişimde piyasaya sürüldü.",
          name: "Baldur's Gate 3",
          imageLink:
              "https://image.api.playstation.com/vulcan/ap/rnd/202302/2321/ba706e54d68d10a0eb6ab7c36cdad9178c58b7fb7bb03d28.png"),
      Game(
          id: 6,
          description:
              "Ori and the Will of the Wisps, Moon Studios tarafından geliştirilen ve Xbox Game Studios tarafından yayınlanan bir platform oyunudur. Oyun, 11 Mart 2020'de Microsoft Windows ve Xbox One için piyasaya sürüldü. Oyun, 17 Eylül 2020'de Nintendo Switch için piyasaya sürüldü.",
          name: "Ori and The Will of The Wisps",
          imageLink:
              "https://upload.wikimedia.org/wikipedia/en/9/94/Ori_and_the_Will_of_the_Wisps.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Game Page"),
      drawer: const CustomDrawer(),
      body: ListView(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 500 ,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text("Celeste", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                              const SizedBox( height: 15,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Release Date: Jan 25, 2018",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                              ),
                              const SizedBox( height: 10,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Released By: Maddy Makes Games ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                              ),
                              const SizedBox( height: 10,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Genre: Adventure, Indie, Platform",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                              ),
                              const SizedBox( height: 10,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Rating: 4.5",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                              ),
                              const SizedBox( height: 10,),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                        
                            ],
                          )
                        ),
                        Container(
                          height: 300,
                          width: 200,
                          decoration:  const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/0/0f/Celeste_box_art_full.png"),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              )
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 500 ,
                child:                     SizedBox(
                      height: 500,
                      child: SingleChildScrollView(
                        child: MarkdownBody(data: content, shrinkWrap: true,),
                      )
                    ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 500 ,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Similar Games: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 235,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0; i < 6; i++) VerticalGameCard(game: itemList[i]),
                        ],
                      ),
                    ),
                 ],
                )
              ),
            ),
          ],
        ),
    );
  }
}

class VerticalGameCard extends StatelessWidget {
  final Game game;

  const VerticalGameCard({
    super.key,
    required this.game
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(game.imageLink),
                fit: BoxFit.fill,
              )
            ),
          ),
          Text(game.name, maxLines: 3,),
        ]
      ),
    );
  }
}