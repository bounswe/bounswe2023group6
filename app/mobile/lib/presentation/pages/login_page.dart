import 'package:flutter/material.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/user_service.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import 'package:mobile/utils/shared_manager.dart';
import 'package:mobile/utils/cache_manager.dart';
import '../widgets/form_widget.dart';
import '../../utils/validation_utils.dart';
import '../../data/services/user_authentication_service.dart';
import '../widgets/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final CacheManager cacheManager = CacheManager();

  // Create an instance of UserAuthenticationService
  final UserAuthenticationService authService = UserAuthenticationService();

  // Define controller names
  final List<String> controllerNames = ['Username', 'Password'];
  
  @override
  void initState() {
    super.initState();
  }


  Future<void> loginUser() async {
    final String username = userNameController.text;
    final String password = passwordController.text;
    String title = "";
    String content = "";
    // Validate user input using ValidationUtils

    if (!username.isEmpty && password.isNotEmpty) {
      
      final loggedIn = await authService.loginUser(username, password);

      if (loggedIn) {
        // Navigate to the next screen or perform other actions for a successful login.
        /*
        if (username == "admin") {
          User user= (await UserService().getUser(username));
          await cacheManager.saveUser(user);
          Navigator.pushNamed(context, '/adminPanel');
          return;
        }
        */
        updateSession(username);
        User user= (await UserService().getUser(username));
        await cacheManager.saveUser(user);

        Navigator.pushNamed(context, '/');
        return;
      } else {
        title = "Error";
        content = "Wrong credentials.";
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

  void updateSession(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormWidget(
              title: 'Please enter your login credentials:',
              controllers: [userNameController, passwordController],
              controllerNames:
                  controllerNames, // Pass controllerNames to FormWidget
              onSubmit: loginUser,
              validators: [
                ValidationUtils.dummyValidation,
                ValidationUtils.dummyValidation
              ],
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
