import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class GamePageCreate extends StatefulWidget {
  final Game? selectedGame;

  const GamePageCreate({Key? key, this.selectedGame}) : super(key: key);

  @override
  State<GamePageCreate> createState() => _GameCreatePageState();
}

class _GameCreatePageState extends State<GamePageCreate> {
  File? _image;
  var title = "Create Game Page";
  var buttonLabel = "Create";
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> _genreList = [
    "Action-Adventure",
    "FPS",
    "MMORPG",
    "Moba",
    "Platform",
    "Sport",
  ];
  String? _selectedGenre;

  final List<String> _platformList = [
    "PlayStation 5",
    "PlayStation 4",
    "Nintendo Switch",
    "PC",
    "XBOX",
    "Steam Deck"
  ];
  String? _selectedPlatform;

  final _playerNumberController = TextEditingController();
  final _releaseYearController = TextEditingController();

  final List<String> _universeList = [
    "Middle Earth",
    "Fantasy",
    "Postapocalyptic",
    "Future",
    "Antic",
    "Football",
  ];
  String? _selectedUniverse;

  final _mechanicsController = TextEditingController();
  final _playTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedGame != null) {
      title = "Update Game Page";
      buttonLabel = "Update";
      _titleController.text = widget.selectedGame!.title;
      _descriptionController.text = widget.selectedGame!.description;
      _selectedGenre = widget.selectedGame!.genre;
      _selectedPlatform = widget.selectedGame!.platform;
      _playerNumberController.text =
          widget.selectedGame!.playerNumber.toString();
      _releaseYearController.text = widget.selectedGame!.releaseYear.toString();
      _selectedUniverse = widget.selectedGame!.universe;
      _mechanicsController.text = widget.selectedGame!.mechanics!;
      _playTimeController.text = widget.selectedGame!.playtime.toString();
      _image = File(widget.selectedGame!.gamePicture);
      // Initialize other fields with selected game properties
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                value: _selectedGenre,
                items: _genreList.map((genre) {
                  return DropdownMenuItem(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGenre = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Genre",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a genre";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedPlatform,
                items: _platformList.map((platform) {
                  return DropdownMenuItem(
                    value: platform,
                    child: Text(platform),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPlatform = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Platform",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a platform";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _playerNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  hintText: "Number of Players",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter number of players";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _releaseYearController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  hintText: "Release Year",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter release year";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedUniverse,
                items: _universeList.map((universe) {
                  return DropdownMenuItem(
                    value: universe,
                    child: Text(universe),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUniverse = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Universe",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a universe";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mechanicsController,
                decoration: const InputDecoration(
                  hintText: "Mechanics",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter mechanics";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _playTimeController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  hintText: "Play Time",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter play time";
                  }
                  return null;
                },
              ),
              Button(
                onPressed: _pickImage,
                label: "Choose Image",
              ),
              const SizedBox(height: 16),
              Button(
                label: buttonLabel,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.selectedGame != null) {
                      //update service will be implemented.
                    } else {
                      GameService().createGame(
                        _titleController.text,
                        _descriptionController.text,
                        _selectedGenre,
                        _selectedPlatform,
                        _playerNumberController.text,
                        _mechanicsController.text,
                        int.parse(_releaseYearController.text),
                        _selectedUniverse,
                        _playTimeController.text,
                        _image, // Pass the image path to your service method
                      );

                      Navigator.of(context).pop("create");
                    }
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
