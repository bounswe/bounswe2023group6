import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class GamePageCreate extends StatefulWidget {
  const GamePageCreate({Key? key}) : super(key: key);

  @override
  State<GamePageCreate> createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GamePageCreate> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _genreController = TextEditingController();
  final _developerController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Game Page"),
        backgroundColor: ColorConstants.color1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                minLines: 3,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  hintText: "Image",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an image";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(
                  hintText: "Genre",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a genre";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _developerController,
                decoration: const InputDecoration(
                  hintText: "Developer",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a developer";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  hintText: "Year",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a year";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Button(
                  label: "Create",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      GameService.addGame(Game(
                          id: GameService.getGameDataList().length + 1,
                          name: _nameController.text,
                          description: _contentController.text,
                          imageLink: _imageController.text,
                          genre: _genreController.text,
                          developers: _developerController.text,
                          releaseYear: _yearController.text));
                      Navigator.of(context).pop("create");
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
