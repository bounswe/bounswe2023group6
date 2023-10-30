import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../widgets/app_bar_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Create an instance of UserAuthenticationService
  final UserAuthenticationService authService = UserAuthenticationService();

  // Define controller names
  final List<String> controllerNames = ['Username', 'Password'];

  void loginUser() {
    final String username = userNameController.text;
    final String password = passwordController.text;
    String title = "";
    String content = "";
    // Validate user input using ValidationUtils
    if (!username.isEmpty && ValidationUtils.isPasswordValid(password)) {
      authService.loginUser(username, password);
    } else {
      if (username.isEmpty) {
        // Handle invalid email
        // You can show an error message or perform any other action here.
        title = "Wrong Username";
        content = "Wrong Username Format";
      } else {
        // Handle invalid password
        // You can show an error message or perform any other action here.
        title = "Wrong Password";
        content = "Wrong Password Format";
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertWidget(
              title: title,
              content: content,
            );
          });
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
        child: FormWidget(
          title: 'Please enter your login credentials:',
          controllers: [userNameController, passwordController],
          controllerNames:
              controllerNames, // Pass controllerNames to FormWidget
          onSubmit: loginUser,
        ),
      ),
    );
  }
}
