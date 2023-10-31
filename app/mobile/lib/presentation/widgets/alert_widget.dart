import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String content;

  AlertWidget({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        Button(
          label: "close",
          onPressed: () {
            Navigator.of(context).pop(); // Close the pop-up
          },
        ),
      ],
    );
  }
}
