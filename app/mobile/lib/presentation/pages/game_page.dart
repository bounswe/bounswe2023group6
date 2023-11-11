import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final List<Game> _gameList = [
    Game(
      id: 1,
      description: "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
      name: "Witcher 3", 
      imageLink: "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"
    ),
    Game(
      id: 2,
      description: "League of Legends (kısaca LoL), Riot Games tarafından geliştirilen ve yayımlanan video oyunu. Microsoft Windows ve macOS işletim sistemlerinde çalışan oyun, tür olarak MOBA (Çok Oyunculu Çevrimiçi Savaş Arenası) olarak adlandırılmaktadır. 27 Ekim 2009'da piyasaya sürülen oyun, 2012 yılında en çok oynanan oyun unvanını aldı. 2014 yılında 67 milyon, 2016 yılında 100 milyon oyuncuya ulaştı. 2020 yılında 115 milyon oyuncuya ulaştı.",
      name: "League of Legends", 
      imageLink: "https://cdn.ntvspor.net/047bed7cbad44a3dae8bdd7b643ab253.jpg?crop=158,0,782,624&w=800&h=800&mode=crop"
    ),
    Game(
      id: 3,
      description: "Call of Duty: WWII, Sledgehammer Games tarafından geliştirilen ve Activision tarafından yayımlanan birinci şahıs nişancı türündeki video oyunudur. Oyun, Call of Duty serisinin 14. oyunu olup 3 Kasım 2017 tarihinde Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürüldü.",
      name: "Call of Duty: WWII", 
      imageLink: "https://upload.wikimedia.org/wikipedia/tr/8/85/Call_of_Duty_WIII_Kapak_Resmi.jpg"
    ),
    Game(
      id: 4,
      description: "Celeste, Kanadalı video oyunu geliştiricisi Matt Thorson tarafından tasarlanan ve geliştirilen bir platform oyunudur. Noel Berry tarafından tasarlanan ve geliştirilen bir platform oyunu olan TowerFall'ın yaratıcısı Matt Thorson tarafından tasarlanan ve geliştirilen bir platform oyunudur. Oyun, 2018'de Microsoft Windows, Nintendo Switch, PlayStation 4, Xbox One, macOS ve Linux için piyasaya sürüldü. Oyun, 2019'da Google Stadia için piyasaya sürüldü.",
      name: "Celeste", 
      imageLink: "https://upload.wikimedia.org/wikipedia/commons/0/0f/Celeste_box_art_full.png"
    ),
    Game(
      id: 5,
      description: "Baldur's Gate 3, Larian Studios tarafından geliştirilen ve Wizards of the Coast tarafından yayınlanan bir rol yapma video oyunudur. Oyun, Dungeons & Dragons 5th edition kurallarına dayanmaktadır. Oyun, 6 Ekim 2020'de Microsoft Windows ve Google Stadia için erken erişimde piyasaya sürüldü.",
      name: "Baldur's Gate 3", 
      imageLink: "https://image.api.playstation.com/vulcan/ap/rnd/202302/2321/ba706e54d68d10a0eb6ab7c36cdad9178c58b7fb7bb03d28.png"
    ),
    Game(
      id: 6,
      description: "Ori and the Will of the Wisps, Moon Studios tarafından geliştirilen ve Xbox Game Studios tarafından yayınlanan bir platform oyunudur. Oyun, 11 Mart 2020'de Microsoft Windows ve Xbox One için piyasaya sürüldü. Oyun, 17 Eylül 2020'de Nintendo Switch için piyasaya sürüldü.",
      name: "Ori and The Will of The Wisps", 
      imageLink: "https://upload.wikimedia.org/wikipedia/en/9/94/Ori_and_the_Will_of_the_Wisps.jpg"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(title: "Game Lounge") ,
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          for (var i = 0; i < 6; i++) GameCard(game: _gameList[i]),
        ],
      )
    );
  }
}