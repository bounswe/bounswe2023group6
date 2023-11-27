import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../widgets/app_bar_widget.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  // Create an instance of UserAuthenticationService
  final UserAuthenticationService authService = UserAuthenticationService();

  final List<String> controllerNames = [
    'Username',
    'Email',
    'Password',
    'Confirm Password'
  ]; // Add controller names

  void registerUser() async {
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmpasswordController.text;

    String title = "";
    String content = "";

    if (username.isNotEmpty &&
        ValidationUtils.isEmailValid(email) &&
        ValidationUtils.isPasswordValid(password) &&
        password == confirmPassword) {
      try {
        final registered =
            await authService.registerUser(username, password, email);

        if (registered) {
          // Navigate to the next screen or perform other actions for a successful login.
          title = "Success";
          content = "Registered";
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login');
        } else {
          title = "Error";
          content = "Error in registration.";
        }
      } catch (error) {
        title = "Error";
        content = "Network error.";
      }
    } else {
      // Validate user input using ValidationUtils
      if (username.isEmpty) {
        // Handle invalid username
        // You can show an error message or perform any other action here.
        title = "Wrong Username";
        content = "Username Cannot Be Empty";
      } else if (!ValidationUtils.isEmailValid(email)) {
        // Handle invalid email
        // You can show an error message or perform any other action here.
        title = "Wrong Email";
        content = "Wrong Email Format";
      } else if (!ValidationUtils.isPasswordValid(password)) {
        // Handle invalid password
        // You can show an error message or perform any other action here.
        title = "Wrong Password";
        content = "Wrong Password Format";
      } else if (password != confirmPassword) {
        title = "Confirm Password";
        content = "Password does not match";
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
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registration',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWidget(
          title: 'Please fill the registration form:',
          controllers: [
            usernameController,
            emailController,
            passwordController,
            confirmpasswordController
          ],
          controllerNames:
              controllerNames, // Pass the controller names to FormWidget
          onSubmit: registerUser,
          validators: const [
            ValidationUtils.usernameValidation,
            ValidationUtils.emailValidation,
            ValidationUtils.passwordValidation,
            ValidationUtils.confirmPasswordValidation
          ],
        ),
      ),
    );
  }
}
