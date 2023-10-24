import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final void Function()? onSubmit;

  const FormWidget({
    Key? key,
    required this.title,
    required this.controllers,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var controller in controllers)
          TextField(
                controller: controller,
                decoration: InputDecoration(labelText: controller.text),
              ),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
