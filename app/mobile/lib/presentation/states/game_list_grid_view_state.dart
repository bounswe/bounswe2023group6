import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/pages/game_page.dart';
import 'package:mobile/presentation/pages/game_wiki_page.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';

class GridViewState extends State {
  int countValue = 2;
  int aspectWidth = 2;
  int aspectHeight = 1;
  final GameService gameService = GameService();
  List<Game> itemList = GameService.getGameDataList();

  Future<List<Game>> loadGames() async {
    List<Game> gameList = await gameService.getGames();

    return gameList;
  }

  changeMode() {
    if (countValue == 2) {
      setState(() {
        countValue = 1;
        aspectWidth = 3;
        aspectHeight = 1;
      });
    } else {
      setState(() {
        countValue = 2;
        aspectWidth = 2;
        aspectHeight = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Future.wait([loadGames()]),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                List<Game> games = snapshot.data![0];
                return Column(children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: countValue,
                      childAspectRatio: (aspectWidth / aspectHeight),
                      children: games
                          .map((data) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/game",
                                    arguments: data.gameId);
                              },
                              child: GameCard(game: data)))
                          .toList(),
                    ),
                  )
                ]);
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
