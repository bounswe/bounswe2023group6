import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class FormWidget extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final List<String> controllerNames;
  final void Function()? onSubmit;

  const FormWidget({
    Key? key,
    required this.title,
    required this.controllers,
    required this.controllerNames,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              for (int i = 0; i < controllers.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0), // Add bottom padding to form fields
                  child: TextField(
                    controller: controllers[i],
                    decoration: InputDecoration(
                      labelText: controllerNames[i],
                    ),
                    obscureText: controllerNames[i].toLowerCase() == 'password', // Conditionally set obscureText
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0), // Add top padding to "Submit" button
                child: Button(
                  onPressed: onSubmit,
                  label: "Submit",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
