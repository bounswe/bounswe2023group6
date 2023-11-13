import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../widgets/app_bar_widget.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Create an instance of UserAuthenticationService
  final UserAuthenticationService authService = UserAuthenticationService();

  // Define controller names
  final List<String> controllerNames = ['Username', 'Email'];

  void forgotPassword() async {
    final String email = emailController.text;
    final String username = usernameController.text;
    String title = "";
    String content = "";

    if (!username.isEmpty && ValidationUtils.isEmailValid(email)) {
      try {
        await authService.forgotPassword(username, email);
        title = "Success";
        content = "Request sent.";
      } catch (error) {
        title = "Error";
        content = "Network error.";
      }
    } else {
      if (username.isEmpty) {
        // Handle invalid email
        // You can show an error message or perform any other action here.
        title = "Wrong Username";
        content = "Wrong Username Format";
      } else {
        // Handle invalid password
        // You can show an error message or perform any other action here.
        title = "Wrong Email";
        content = "Wrong Email Format";
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Forgot Password',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWidget(
          title: 'Please enter your email and username:',
          controllers: [usernameController, emailController],
          controllerNames:
              controllerNames, // Pass controllerNames to FormWidget
          onSubmit: forgotPassword,
          validators: [
            ValidationUtils.dummyValidation,
            ValidationUtils.dummyValidation
          ],
        ),
      ),
    );
  }
}
