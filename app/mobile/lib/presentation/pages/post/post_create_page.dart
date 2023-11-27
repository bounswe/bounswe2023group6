import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/game_model.dart';
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
  final List<Game> _gameList = GameService.getGameDataList();
  Game? _selectedGame;

  @override
  Widget build(BuildContext context) {
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
              DropdownButtonFormField(
                value: _selectedGame,
                items: _gameList.map((game) {
                  return DropdownMenuItem(
                    value: game,
                    child: Text(game.title),
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

              Button(
                label: "Create",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await PostService().createPost(
                        _titleController.text, _contentController.text);
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
}
