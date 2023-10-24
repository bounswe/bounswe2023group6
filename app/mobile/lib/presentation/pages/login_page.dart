import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Button(
              label: 'Login',
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                // final loginResult = await LoginUtil.loginUser(email, password);
                // if (loginResult) {
                //   // Login was successful, navigate to another page (e.g., home)
                //   Navigator.pushReplacementNamed(context, '/home'); // Navigate to the home page
                // } else {
                //   // Login failed, handle the error (e.g., show an error message)
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
