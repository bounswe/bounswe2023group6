import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({Key? key}) : super(key: key);

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _titleController = TextEditingController();
  // final List<Game> _gameList = [
  //   Game(id: 1, name: "League of Legends", description: "MOBA", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/league-of-legends-1.jpg"),
  //   Game(id: 2, name: "Valorant", description: "FPS", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/03/10105952/valorant-1.jpg"),
  //   Game(id: 3, name: "Overwatch", description: "FPS", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/overwatch-1.jpg"),
  //   Game(id: 4, name: "Apex Legends", description: "FPS", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/apex-legends-1.jpg"),
  //   Game(id: 5, name: "Fortnite", description: "Battle Royale", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/fortnite-1.jpg"),
  //   Game(id: 6, name: "Call of Duty: Warzone", description: "Battle Royale", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/call-of-duty-warzone-1.jpg"),
  //   Game(id: 7, name: "Counter-Strike: Global Offensive", description: "FPS", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/counter-strike-global-offensive-1.jpg"),
  //   Game(id: 8, name: "Rocket League", description: "Sports", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/rocket-league-1.jpg"),
  //   Game(id: 9, name: "Hearthstone", description: "Card Game", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/hearthstone-1.jpg"),
  //   Game(id: 10, name: "Teamfight Tactics", description: "Auto Battler", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/teamfight-tactics-1.jpg"),
  //   Game(id: 11, name: "Dota Underlords", description: "Auto Battler", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/dota-underlords-1.jpg"),
  //   Game(id: 12, name: "Legends of Runeterra", description: "Card Game", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/legends-of-runeterra-1.jpg"),
  //   Game(id: 13, name: "Magic: The Gathering Arena", description: "Card Game", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/magic-the-gathering-arena-1.jpg"),
  //   Game(id: 14, name: "FIFA 21", description: "Sports", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/fifa-21-1.jpg"),
  //   Game(id: 15, name: "NBA 2K21", description: "Sports", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/nba-2k21-1.jpg"),
  //   Game(id: 16, name: "Madden NFL 21", description: "Sports", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/madden-nfl-21-1.jpg"),
  //   Game(id: 17, name: "Super Smash Bros. Ultimate", description: "Fighting", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/super-smash-bros-ultimate-1.jpg"),
  //   Game(id: 18, name: "Pokémon Sword and Shield", description: "RPG", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/pokemon-sword-and-shield-1.jpg"),
  //   Game(id: 19, name: "Animal Crossing: New Horizons", description: "Simulation", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/animal-crossing-new-horizons-1.jpg"),
  //   Game(id: 20, name: "Minecraft", description: "Sandbox", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/minecraft-1.jpg"),
  //   Game(id: 21, name: "World of Warcraft", description: "MMORPG", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/world-of-warcraft-1.jpg"),
  //   Game(id: 22, name: "Old School RuneScape", description: "MMORPG", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/old-school-runescape-1.jpg"),
  //   Game(id: 23, name: "Final Fantasy XIV", description: "MMORPG", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/final-fantasy-xiv-1.jpg"),
  //   Game(id: 24, name: "Path of Exile", description: "MMORPG", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/path-of-exile-1.jpg"),
  //   Game(id: 25, name: "Diablo III", description: "MMORPG", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/diablo-iii-1.jpg"),
  //   Game(id: 26, name: "Rust", description: "Survival", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/rust-1.jpg"),
  //   Game(id: 27, name: "Among Us", description: "Social Deduction", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/among-us-1.jpg"),
  //   Game(id: 28, name: "Phasmophobia", description: "Horror", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/phasmophobia-1.jpg"),
  //   Game(id: 29, name: "Dead by Daylight", description: "Horror", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/dead-by-daylight-1.jpg"),
  //   Game(id: 30, name: "Escape from Tarkov", description: "FPS", imageLink: "https://cdn1.dotesports.com/wp-content/uploads/2020/01/10105952/escape-from-tarkov-1.jpg"),
  // ];
  int? _selectedGame;

  Future<List<Game>> loadGameData() async {
    return await GameService().getGames(); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadGameData(), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildPostCreatePage(context, snapshot.data as List<Game>);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildPostCreatePage(BuildContext context, List<Game> gameList) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        backgroundColor: ColorConstants.color3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                minLines: 3,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "Content",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a content";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Option selection for game
              buildGameDropdown(gameList),
              const SizedBox(height: 16),

              Button(
                label: "Create",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await PostService().createPost(
                        _titleController.text, 
                        _contentController.text, 
                        _selectedGame!
                      );
                    Navigator.of(context).pop("create");
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildGameDropdown(List<Game> gameList) {
    return DropdownButtonFormField<int>(
      value: _selectedGame,
      decoration: const InputDecoration(
        hintText: "Select a game",
      ),
      items: gameList.map((game) {
        return DropdownMenuItem<int>(
          value: game.gameId,
          child: Row(
            children: [
              Image.network(game.gamePicture, width: 50, height: 50),
              const SizedBox(width: 16),
              Text(game.title),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGame = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return "Please select a game";
        }
        return null;
      },
    );
  }
}
