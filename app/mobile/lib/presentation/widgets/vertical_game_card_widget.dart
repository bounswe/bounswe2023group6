import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';

class VerticalGameCard extends StatelessWidget {
  final Game game;

  const VerticalGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/game", arguments: game.gameId);
      },
      child: SizedBox(
        width: 130,
        child: Column(children: [
          Container(
            height: 160,
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(game.gamePicture),
              fit: BoxFit.fill,
            )),
          ),
          Text(
            game.title,
            maxLines: 3,
          ),
        ]),
      ),
    );
  }
}
