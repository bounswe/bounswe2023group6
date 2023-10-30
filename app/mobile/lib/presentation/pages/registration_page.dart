import 'package:flutter/material.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/models/user_model.dart';
import '../widgets/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Create an instance of UserAuthenticationService

  final List<String> controllerNames = ['Name', 'Surname', 'Email', 'Password']; // Add controller names

  void registerUser() {
    final String name = nameController.text;
    final String surname = surnameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    // Validate user input using ValidationUtils
    if (!ValidationUtils.isNameValid(name)) {
      // Handle invalid name
      // You can show an error message or perform any other action here.
    } else if (!ValidationUtils.isNameValid(surname)) {
      // Handle invalid email
      // You can show an error message or perform any other action here.
    } else if (!ValidationUtils.isEmailValid(email)) {
      // Handle invalid email
      // You can show an error message or perform any other action here.
    } else if (!ValidationUtils.isPasswordValid(password)) {
      // Handle invalid password
      // You can show an error message or perform any other action here.
    } else {
      // Proceed with user registration using the UserAuthenticationService
      final user = User(
        name: name,
        surname: surname,
        email: email,
        password: password,
      );
    }
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
          controllers: [nameController, surnameController, emailController, passwordController],
          controllerNames: controllerNames, // Pass the controller names to FormWidget
          onSubmit: registerUser,
        ),
      ),
    );
  }
}
