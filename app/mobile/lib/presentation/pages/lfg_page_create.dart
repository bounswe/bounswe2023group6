import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'package:mobile/presentation/widgets/tag_input.dart';

class LFGPageCreate extends StatefulWidget {
  final LFG? selectedLFG;
  const LFGPageCreate({Key? key, this.selectedLFG}) : super(key: key);

  @override
  State<LFGPageCreate> createState() => _LFGCreatePageState();
}

class _LFGCreatePageState extends State<LFGPageCreate> {
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  var title = "Create LFG Page";
  var buttonLabel = "Create";
  final List<String> _platformList = [
    "XBOX",
    "COMPUTER",
    "PS", // PlayStation
    "ONBOARD",
    "EMPTY"
  ];
  String? _selectedPlatform;
  int? _selectedGame;
  final List<String> _languageList = [
    "TUR",
    "EN",
  ];
  String? _selectedLanguage;
  List<String> _tags = [];
  bool micCamRequired = false;
  final _capacityController = TextEditingController();
  final _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedLFG != null) {
<<<<<<< HEAD
      title = "Update Game Page";
=======
      title = "Update LFG Page";
>>>>>>> develop
      buttonLabel = "Update";
      _titleController.text = widget.selectedLFG!.title!;
      _descriptionController.text = widget.selectedLFG!.content!;
      _selectedPlatform = _platformList[0];
      _selectedLanguage = _languageList[1];
      micCamRequired = widget.selectedLFG!.micCamRequirement!;
      _capacityController.text = widget.selectedLFG!.memberCapacity.toString();
      _tags = widget.selectedLFG!.tags!;
    }
  }

<<<<<<< HEAD
=======
  Future<List<Game>> loadGameData() async {
    return await GameService().getGames();
  }

>>>>>>> develop
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadGameData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildLFGCreatePage(context, snapshot.data as List<Game>);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildLFGCreatePage(BuildContext context, List<Game> gameList) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: ColorConstants.color3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the title";
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
                    return "Please enter the description";
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
              DropdownButtonFormField(
                value: _selectedLanguage,
                items: _languageList.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value as String;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Language",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a language";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: micCamRequired,
                    onChanged: (value) {
                      setState(() {
                        micCamRequired = value!;
                      });
                    },
                  ),
                  const Text("Mic/Cam Required"),
                ],
              ),
              TextFormField(
                controller: _capacityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  hintText: "Group Capacity",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the capacity of the group";
                  }
                  return null;
                },
              ),
              TagInput(tags: _tags, tagController: _tagController),
              const SizedBox(height: 16),
              buildGameDropdown(gameList),
              const SizedBox(height: 16),
              Button(
                label: buttonLabel,
<<<<<<< HEAD
                onPressed: () async {},
=======
                onPressed: () async {
                  if (widget.selectedLFG == null) {
                    LFGService().createLFG(
                        _titleController.text,
                        _descriptionController.text,
                        _selectedPlatform!,
                        _selectedLanguage!,
                        micCamRequired,
                        int.parse(_capacityController.text),
                        _selectedGame,
                        _tags);
                  } else {
                    //update
                  }
                  Navigator.of(context).pop("create");
                },
>>>>>>> develop
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
