import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/game/game_create_dto_request.dart';
import 'package:mobile/data/models/dto/game/game_request.dart';
import 'package:mobile/data/models/dto/game/game_response.dart';
import 'package:mobile/data/models/dto/game/multiple_game_dto_response.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'package:mobile/utils/shared_manager.dart';
import 'package:provider/provider.dart';

class GameService {
  static const String serverUrl = NetworkConstants.BASE_LOCAL_URL;

  final BaseNetworkService service = BaseNetworkService();

  static const String _getGames = "/game";
  static List<Game> gameList = [
    Game(
      gameId: 1,
      description:
          "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
      title: "Witcher 3",
      gamePicture:
          "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png",
      genre: "Adventure, Role-playing(RPG)",
      developers: "CD Projekt RED",
      releaseYear: "May 19, 2015",
      platform:
          " Xbox One, PlayStation 4, PlayStation 5, PC (Microsoft Windows), Nintendo Switch, Xbox Series X|S",
      playerNumber: "Single Player",
      universe: "Fantasy",
      mechanics: "Third-person",
    ),
    Game(
      gameId: 2,
      description:
          "League of Legends (kısaca LoL), Riot Games tarafından geliştirilen ve yayımlanan video oyunu. Microsoft Windows ve macOS işletim sistemlerinde çalışan oyun, tür olarak MOBA (Çok Oyunculu Çevrimiçi Savaş Arenası) olarak adlandırılmaktadır. 27 Ekim 2009'da piyasaya sürülen oyun, 2012 yılında en çok oynanan oyun unvanını aldı. 2014 yılında 67 milyon, 2016 yılında 100 milyon oyuncuya ulaştı. 2020 yılında 115 milyon oyuncuya ulaştı.",
      title: "League of Legends",
      gamePicture:
          "https://cdn.ntvspor.net/047bed7cbad44a3dae8bdd7b643ab253.jpg?crop=158,0,782,624&w=800&h=800&mode=crop",
      genre: "MOBA, Role-playing(RPG), Strategy",
      developers: "Riot Games",
      releaseYear: "Oct 27, 2009",
    ),
    Game(
      gameId: 3,
      description:
          "Call of Duty: WWII, Sledgehammer Games tarafından geliştirilen ve Activision tarafından yayımlanan birinci şahıs nişancı türündeki video oyunudur. Oyun, Call of Duty serisinin 14. oyunu olup 3 Kasım 2017 tarihinde Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürüldü.",
      title: "Call of Duty: WWII",
      gamePicture:
          "https://upload.wikimedia.org/wikipedia/tr/8/85/Call_of_Duty_WIII_Kapak_Resmi.jpg",
      genre: "Shooter",
      developers: "Sledgehammer Games",
      releaseYear: "Nov 02, 2017",
    ),
    Game(
      gameId: 4,
      description: """ 
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

  """,
      title: "Celeste",
      gamePicture:
          "https://upload.wikimedia.org/wikipedia/commons/0/0f/Celeste_box_art_full.png",
      genre: "Adventure, Indie, Platform",
      developers: "Maddy Makes Games",
      releaseYear: "Jan 25, 2018",
    ),
    Game(
      gameId: 5,
      description:
          "Baldur's Gate 3, Larian Studios tarafından geliştirilen ve Wizards of the Coast tarafından yayınlanan bir rol yapma video oyunudur. Oyun, Dungeons & Dragons 5th edition kurallarına dayanmaktadır. Oyun, 6 Ekim 2020'de Microsoft Windows ve Google Stadia için erken erişimde piyasaya sürüldü.",
      title: "Baldur's Gate 3",
      gamePicture:
          "https://image.api.playstation.com/vulcan/ap/rnd/202302/2321/ba706e54d68d10a0eb6ab7c36cdad9178c58b7fb7bb03d28.png",
      genre:
          "Adventure, Role-playing (RPG), Strategy, Tactical, Turn-based strategy (TBS)",
      developers: "Larian Studios",
      releaseYear: "Oct 06, 2020",
    ),
    Game(
      gameId: 6,
      description:
          "Ori and the Will of the Wisps, Moon Studios tarafından geliştirilen ve Xbox Game Studios tarafından yayınlanan bir platform oyunudur. Oyun, 11 Mart 2020'de Microsoft Windows ve Xbox One için piyasaya sürüldü. Oyun, 17 Eylül 2020'de Nintendo Switch için piyasaya sürüldü.",
      title: "Ori and The Will of The Wisps",
      gamePicture:
          "https://upload.wikimedia.org/wikipedia/en/9/94/Ori_and_the_Will_of_the_Wisps.jpg",
      genre: "Adventure, Platform",
      developers: "Moon Studios",
      releaseYear: "Mar 10, 2020",
    ),
  ];

  Future<List<Game>> getGames() async {
    if (NetworkConstants.useMockGameData) {
      return getGameDataList();
    }

    ServiceResponse<MultipleGameAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleGameAsDTO>(
      _getGames,
      null,
      MultipleGameAsDTO(),
      'GET',
    );
    if (response.success) {
      List<Game> games =
          response.responseConverted!.games!.map((e) => e as Game).toList();
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  Future<Game> getGame(int gameid) async {
    if (NetworkConstants.useMockGameData) {
      return getGameDataList()[gameid - 1];
    }

    ServiceResponse<GameDTOResponse> response =
        await service.sendRequestSafe<EmptyResponse, GameDTOResponse>(
      "$_getGames/$gameid",
      null,
      GameDTOResponse(),
      'GET',
    );
    if (response.success) {
      Game game = response.responseConverted! as Game;
      return game;
    } else {
      throw Exception('Failed to load game');
    }
  }

  static Game getGameStatic(int id) {
    return getGameDataList()[id];
  }

  static List<Game> getGameDataList() {
    return gameList;
  }

  Future<void> createGame(
      String title,
      String description,
      String? genre,
      String? platform,
      String numberOfPlayer,
      int year,
      String? universe,
      String playTime,
      File file) async {
    if (NetworkConstants.useMockData) {
      gameList.add(Game(
          gameId: gameList.length + 1,
          title: title,
          description: description,
          gamePicture: ""));
    } 
    GameCreateDTORequest gameCreateDTORequest = GameCreateDTORequest(
      title: title,
      description: description,
      genre: genre,
      platform: platform,
      numberOfPlayer: numberOfPlayer,
      year: year,
      universe: universe,
      playtime: playTime);

    final SharedManager manager = SharedManager();
    await manager.init();
    if (!manager.checkString(SharedKeys.sessionId)) {
      throw Exception('Session id is null');
    }
    String sessionID = manager.getString(SharedKeys.sessionId);  

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
        "request": gameCreateDTORequest.toJson(),
        "image":
            await MultipartFile.fromFile(file.path, filename:fileName),
    });

    Response response = await Dio().post(
      service.options.baseUrl + "/game", 
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Cookie': 'SESSIONID=$sessionID'
        },
      ),      
    );
    
    return response.data['gameId'];
  }
}
