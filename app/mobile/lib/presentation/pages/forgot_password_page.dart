import 'package:flutter/material.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../widgets/app_bar_widget.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // Create an instance of UserAuthenticationService

  // Define controller names
  final List<String> controllerNames = ['Email', 'Username'];

  void forgotPassword() {
    final String email = emailController.text;
    final String username = usernameController.text;

    // Validate user input using ValidationUtils
    if (!ValidationUtils.isEmailValid(email)) {
      // Handle invalid email
      // You can show an error message or perform any other action here.
    } else {
      print(username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Forgot Password',
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWidget(
          title: 'Please enter your email and username:',
          controllers: [emailController,usernameController],
          controllerNames:
              controllerNames, // Pass controllerNames to FormWidget
          onSubmit: forgotPassword,
        ),
      ),
    );
  }
}
