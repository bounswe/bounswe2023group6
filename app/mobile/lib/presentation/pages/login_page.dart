import 'package:flutter/material.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../widgets/app_bar_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Create an instance of UserAuthenticationService
  final UserAuthenticationService authService = UserAuthenticationService();

  // Define controller names
  final List<String> controllerNames = ['Email', 'Password'];

  void loginUser() {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Validate user input using ValidationUtils
    if (!ValidationUtils.isEmailValid(email)) {
      // Handle invalid email
      // You can show an error message or perform any other action here.
    } else if (!ValidationUtils.isPasswordValid(password)) {
      // Handle invalid password
      // You can show an error message or perform any other action here.
    } else {
      // Proceed with user login using the UserAuthenticationService
      authService.loginUser(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormWidget(
              title: 'Please enter your login credentials:',
              controllers: [emailController, passwordController],
              controllerNames: controllerNames, // Pass controllerNames to FormWidget
              onSubmit: loginUser,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/forgot');
              },
              child: const Text("Forgot Password"),
            ),
          ],
        ),
      ),
    );
  }
}
