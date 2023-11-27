
import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';

class VerticalGameCard extends StatelessWidget {
  final Game game;

  const VerticalGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/game", arguments: game.id);
      },
      child: SizedBox(
        width: 130,
        child: Column(children: [
          Container(
            height: 160,
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(game.imageLink),
              fit: BoxFit.fill,
            )),
          ),
          Text(
            game.name,
            maxLines: 3,
          ),
        ]),
      ),
    );
  }
}
