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

  List<Game> itemList = GameService.getGameDataList();

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

  getGridViewSelectedItem(BuildContext context, Game gridItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
          title: gridItem.name,
          content: gridItem.description,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      /*Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Button(
            onPressed: () => changeMode(),
            label: 'Change GridView Mode To ListView ',
          )),*/
      Expanded(
        child: GridView.count(
          crossAxisCount: countValue,
          childAspectRatio: (aspectWidth / aspectHeight),
          children: itemList
              .map((data) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/game", arguments: data.id);
                    //getGridViewSelectedItem(context, data);
                  },
                  child: GameCard(game: data)))
              .toList(),
        ),
      )
    ]));
  }
}
