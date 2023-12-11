import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class LFGPageCreate extends StatefulWidget {
  const LFGPageCreate({Key? key}) : super(key: key);

  @override
  State<LFGPageCreate> createState() => _LFGCreatePageState();
}

class _LFGCreatePageState extends State<LFGPageCreate> {
  final _descriptionController = TextEditingController();
  final List<String> _gameList = [
    "World of Warcraft",
    "Apex Legends",
    "Borderlands 3",
    "Destiny 2",
    "Fortnite",
  ];
  String? _selectedGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create LFG Page"),
        backgroundColor: ColorConstants.color3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(children: [
              TextFormField(
                controller: _descriptionController,
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
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedGame,
                items: _gameList.map((game) {
                  return DropdownMenuItem(
                    value: game,
                    child: Text(game),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGame = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Game",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a game";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Button(
                label: "Create",
                onPressed: () async {},
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
