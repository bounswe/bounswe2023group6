import 'package:flutter/material.dart';
import '../widgets/big_button_widget.dart';
import '../widgets/medium_button_widget.dart';
import '../widgets/small_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BigButton(
              label: 'Button',
              onPressed: () {
                // Handle big button press
              },
            ),
            MediumButton(
              label: 'Button',
              onPressed: () {
                // Handle medium button press
              },
            ),
            SmallButton(
              label: 'Button',
              onPressed: () {
                // Handle small button press
              },
            ),
          ],
        ),
      ),
    );
  }
}

