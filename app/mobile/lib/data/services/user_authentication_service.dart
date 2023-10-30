import 'package:http/http.dart' as http;
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';
import 'package:mobile/data/models/login_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'dart:convert';
import '../../data/models/user_model.dart';

class UserAuthenticationService {
  static const String serverUrl =
      NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  Future<bool> loginUser(String username, String password) async {
    const loginUrl = '$serverUrl/login';

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    print(loginUrl);
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final User user = User.fromJson(responseData);
        print('Login successful');
        print('User: ${user.name} ${user.surname}');
        return true;
      } else {
        print('Login failed - Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  Future<bool> registerUser(User user) async {
    try {
      final data = jsonEncode(user.toJson());
      print(data);

      final response = await http.post(
        Uri.parse('$serverUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        print('Registration successful');
        return true;
      } else {
        print('Registration failed - Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Registration failed: $e');
      return false;
    }
  }

  // Log out the current user
  Future<void> logout() async {
    // You can add any necessary logic for logging out here
    // For example, clearing user data or tokens
  }

  // Reset the user's password
  Future<bool> resetPassword(String email) async {
    try {
      // Implement the logic for resetting the user's password
      // You can send a reset password link to the user's email
      // or use an API for password reset
      return true; // Return true if the reset request was successful
    } catch (e) {
      print('Password reset failed: $e');
      return false;
    }
  }

  // Get the current user
  Future<User?> getCurrentUser() async {
    try {
      // Implement the logic for retrieving the current user
      // This might involve checking the user's session or token
      // and fetching user details from your API
      // If no user is logged in, return null
      return User(
          name: 'John',
          surname: 'Doe',
          email: 'john.doe@example.com',
          username: 'johndoe',
          password: '***');
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }
}
