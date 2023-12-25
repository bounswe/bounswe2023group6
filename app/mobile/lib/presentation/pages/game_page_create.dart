// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

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

  List<dynamic>? genreList = [
    {
      "display": "RGP",
      "value": "RGP",
    },
    {
      "display": "Strategy",
      "value": "Strategy",
    },
    {
      "display": "Shooter",
      "value": "Shooter",
    },
    {
      "display": "Sports",
      "value": "Sports",
    },
    {
      "display": "Fighting",
      "value": "Fighting",
    },
    {
      "display": "MOBA",
      "value": "MOBA",
    },
    {
      "display": "Action",
      "value": "Action",
    },
    {
      "display": "Adventure",
      "value": "Adventure",
    },
    {
      "display": "Simulation",
      "value": "Simulation",
    },
    {
      "display": "Horror",
      "value": "Horror",
    },
    {
      "display": "Empty",
      "value": "Empty",
    },
  ];
  List<dynamic>? platformList = [
    {
      "display": "XBOX",
      "value": "XBOX",
    },
    {
      "display": "Computer",
      "value": "Computer",
    },
    {
      "display": "PS",
      "value": "PS",
    },
    {
      "display": "Onboard",
      "value": "Onboard",
    },
    {
      "display": "Mobile",
      "value": "Mobile",
    },
    {
      "display": "Empty",
      "value": "Empty",
    }
  ];
  List<dynamic> _selectedPlatforms = [];
  List<dynamic> _selectedGenres = [];

  final _releaseYearController = TextEditingController();

  final List<String> _playerNumberList = [
    "Single",
    "Teams",
    "Multiplayer",
    "MMO", // Massively Multiplayer Online
    "Empty"
  ];
  String? _selectedPlayerNumber;

  final List<String> _universeList = [
    "Medieval",
    "Fantasy",
    "SciFi",
    "Cyberpunk",
    "Historical",
    "Contemporary",
    "PostApocalyptic",
    "AlternateReality",
    "Empty"
  ];

  String? _selectedUniverse;

  final List<String> _gameMechanicsist = [
    "TurnBased",
    "ChangeBased",
    "RealTime",
    "Empty"
  ];

  String? _selectedGameMechanics;

  final _playTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedGame != null) {
      title = "Update Game Page";
      buttonLabel = "Update";
      _titleController.text = widget.selectedGame!.title;
      _descriptionController.text = widget.selectedGame!.description;
      _selectedGenres = widget.selectedGame!.genres!;
      _selectedPlatforms = widget.selectedGame!.platforms!;
      _selectedPlayerNumber = widget.selectedGame!.playerNumber;
      _releaseYearController.text = widget.selectedGame!.releaseYear.toString();
      _selectedUniverse = widget.selectedGame!.universe;
      _selectedGameMechanics = widget.selectedGame!.mechanics;
      _playTimeController.text = widget.selectedGame!.playtime.toString();
      _image = File(widget.selectedGame!.gamePicture);
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
              MultiSelectFormField(
                autovalidate: AutovalidateMode.disabled,
                chipBackGroundColor: ColorConstants.color1,
                chipLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: ColorConstants.color1,
                checkBoxCheckColor: ColorConstants.color3,
                dialogShapeBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: const Text(
                  "Select genres",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: genreList,
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                hintWidget: const Text('Please choose one or more'),
                initialValue: _selectedGenres,
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedGenres = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              MultiSelectFormField(
                autovalidate: AutovalidateMode.disabled,
                chipBackGroundColor: ColorConstants.color1,
                chipLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: ColorConstants.color1,
                checkBoxCheckColor: ColorConstants.color3,
                dialogShapeBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: const Text(
                  "Select platforms",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: platformList,
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                hintWidget: const Text('Please choose one or more'),
                initialValue: _selectedPlatforms,
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedPlatforms = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedPlayerNumber,
                items: _playerNumberList.map((playerNumber) {
                  return DropdownMenuItem(
                    value: playerNumber,
                    child: Text(playerNumber),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPlayerNumber = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Number of Players",
                ),
                validator: (value) {
                  if (value == null) {
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
              DropdownButtonFormField(
                value: _selectedGameMechanics,
                items: _gameMechanicsist.map((mechanics) {
                  return DropdownMenuItem(
                    value: mechanics,
                    child: Text(mechanics),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGameMechanics = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Mechanics",
                ),
                validator: (value) {
                  if (value == null) {
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
              widget.selectedGame == null
                  ? Button(
                      onPressed: _pickImage,
                      label: "Choose Image",
                    )
                  : SizedBox(),
              const SizedBox(height: 16),
              Button(
                label: buttonLabel,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.selectedGame != null) {
                      GameService().updateGameNew(
                          _titleController.text,
                          _descriptionController.text,
                          _selectedGenres.cast<String>(),
                          _selectedPlatforms.cast<String>(),
                          _selectedPlayerNumber,
                          _selectedGameMechanics,
                          int.parse(_releaseYearController.text),
                          _selectedUniverse,
                          _playTimeController.text,
                          widget.selectedGame!.gameId);

                      Navigator.of(context).pop("create");
                    } else {
                      GameService().createGame(
                        _titleController.text,
                        _descriptionController.text,
                        _selectedGenres.cast<String>(),
                        _selectedPlatforms.cast<String>(),
                        _selectedPlayerNumber,
                        _selectedGameMechanics,
                        int.parse(_releaseYearController.text),
                        _selectedUniverse,
                        _playTimeController.text,
                        _image,
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
