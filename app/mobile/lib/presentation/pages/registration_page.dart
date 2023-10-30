import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../../data/models/user_model.dart';
import '../widgets/app_bar_widget.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Create an instance of UserAuthenticationService
  final UserAuthenticationService authService = UserAuthenticationService();

  final List<String> controllerNames = [
    'Name',
    'Surname',
    'Username',
    'Email',
    'Password'
  ]; // Add controller names

  void registerUser() async {
    final String name = nameController.text;
    final String surname = surnameController.text;
    final String username = userNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    String title = "";
    String content = "";

    if (ValidationUtils.isNameValid(name) &&
        ValidationUtils.isNameValid(surname) &&
        !username.isEmpty &&
        ValidationUtils.isEmailValid(email) &&
        ValidationUtils.isPasswordValid(password)) {
      final user = User(
          name: name,
          surname: surname,
          email: email,
          password: password,
          username: username);

      try {
        final registered = await authService.registerUser(user);

        if (registered) {
          // Navigate to the next screen or perform other actions for a successful login.

          title = "Success";
          content = "Registered";
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
      if (!ValidationUtils.isNameValid(name)) {
        title = "Wrong Name";
        content = "Wrong Name Format";
      } else if (!ValidationUtils.isNameValid(surname)) {
        title = "Wrong Surname";
        content = "Wrong Surname Format";
      } else if (username.isEmpty) {
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
      appBar: const CustomAppBar(
        title: 'Registration',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWidget(
          title: 'Please fill the registration form:',
          controllers: [
            nameController,
            surnameController,
            userNameController,
            emailController,
            passwordController
          ],
          controllerNames:
              controllerNames, // Pass the controller names to FormWidget
          onSubmit: registerUser,
        ),
      ),
    );
  }
}
