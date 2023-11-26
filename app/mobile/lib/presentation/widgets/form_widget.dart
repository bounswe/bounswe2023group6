import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class FormWidget extends StatelessWidget {


  const FormWidget({
    Key? key,
    required this.title,
    required this.controllers,
    required this.controllerNames,
    this.onSubmit, 
    required this.validators,
  }) : super(key: key);

  final String title;
  final List<TextEditingController> controllers;
  final List<String> controllerNames;
  final List<Function> validators;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
                for (int i = 0; i < controllers.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0), // Add bottom padding to form fields
                    child: TextFormField(
                      controller: controllers[i],
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).focusColor)),
                        floatingLabelStyle:
                            TextStyle(color: Theme.of(context).focusColor),
                        labelText: controllerNames[i],
                      ),
                      obscureText: ['password', 'confirm password'].contains(controllerNames[i].toLowerCase()),// Conditionally set obscureText
                      textInputAction: (i == controllers.length-1) ? TextInputAction.done : TextInputAction.next,
                      validator: controllerNames[i].toLowerCase() != 'confirm password' ? (value) => validators[i](value) : (value) => validators[i](value, controllers[i-1].text),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 70.0), // Add top padding to "Submit" button
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
