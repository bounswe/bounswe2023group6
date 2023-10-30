import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import '../../constants/text_constants.dart';

class AuthPageDemo extends StatelessWidget {
  const AuthPageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // First Row: Logo
            Container(
              width: 600,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/logo.png'),
                ),
              ),
            ),

            // Second Row: Description
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
              TextConstants.descriptionText,
              style: TextStyle(fontSize: 16),
              ),
            ),

            // Third Row: Registration and Login Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // Adjust the value as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Button(
                    label: 'Registration',
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                  ),
                  Button(
                    label: 'Login',
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
