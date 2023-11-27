import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({
    super.key, required this.game,
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
                      image: NetworkImage(game.gamePicture),
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
                    child: Text(game.title),
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

