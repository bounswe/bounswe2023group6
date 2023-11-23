import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/post_service.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({Key? key}) : super(key: key);

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _titleController = TextEditingController();
  final List<Game> _gameList = [
    Game(id: 1, name: "League of Legends", description: "MOBA"),
    Game(id: 2, name: "Valorant", description: "FPS"),
    Game(id: 3, name: "Overwatch", description: "FPS"),
    Game(id: 4, name: "Apex Legends", description: "FPS"),
    Game(id: 5, name: "Fortnite", description: "Battle Royale"),
    Game(id: 6, name: "Call of Duty: Warzone", description: "Battle Royale"),
    Game(id: 7, name: "Counter-Strike: Global Offensive", description: "FPS"),
    Game(id: 8, name: "Rocket League", description: "Sports"),
    Game(id: 9, name: "Hearthstone", description: "Card Game"),
    Game(id: 10, name: "Teamfight Tactics", description: "Auto Battler"),
    Game(id: 11, name: "Dota Underlords", description: "Auto Battler"),
    Game(id: 12, name: "Legends of Runeterra", description: "Card Game"),
    Game(id: 13, name: "Magic: The Gathering Arena", description: "Card Game"),
    Game(id: 14, name: "FIFA 21", description: "Sports"),
    Game(id: 15, name: "NBA 2K21", description: "Sports"),
    Game(id: 16, name: "Madden NFL 21", description: "Sports"),
    Game(id: 17, name: "Super Smash Bros. Ultimate", description: "Fighting"),
    Game(id: 18, name: "Pokémon Sword and Shield", description: "RPG"),
    Game(id: 19, name: "Animal Crossing: New Horizons", description: "Simulation"),
    Game(id: 20, name: "Minecraft", description: "Sandbox"),
    Game(id: 21, name: "World of Warcraft", description: "MMORPG"),
    Game(id: 22, name: "Old School RuneScape", description: "MMORPG"),
    Game(id: 23, name: "Final Fantasy XIV", description: "MMORPG"),
    Game(id: 24, name: "Path of Exile", description: "MMORPG"),
    Game(id: 25, name: "Diablo III", description: "MMORPG"),
    Game(id: 26, name: "Rust", description: "Survival"),
    Game(id: 27, name: "Among Us", description: "Social Deduction"),
    Game(id: 28, name: "Phasmophobia", description: "Horror"),
    Game(id: 29, name: "Dead by Daylight", description: "Horror"),
    Game(id: 30, name: "Escape from Tarkov", description: "FPS"),
  ];
  Game? _selectedGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
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
              DropdownButtonFormField(
                value: _selectedGame,
                items: _gameList.map((game) {
                  return DropdownMenuItem(
                    value: game,
                    child: Text(game.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGame = value as Game;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Related Game",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a related game for the post";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await PostService().createPost(
                        _titleController.text, 
                        _contentController.text
                      );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("Post created"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("Create"),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
