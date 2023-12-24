import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'package:mobile/presentation/widgets/tag_input.dart';

class LFGPageCreate extends StatefulWidget {
  const LFGPageCreate({Key? key}) : super(key: key);

  @override
  State<LFGPageCreate> createState() => _LFGCreatePageState();
}

class _LFGCreatePageState extends State<LFGPageCreate> {
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final List<String> _platformList = [
    "XBOX",
    "COMPUTER",
    "PS", // PlayStation
    "ONBOARD",
    "EMPTY"
  ];
  String? _selectedPlatform;
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
