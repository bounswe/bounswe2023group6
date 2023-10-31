import 'package:http/http.dart' as http;
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';
import 'package:mobile/data/models/dto/user/user_response.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'dart:convert';
import '../../data/models/user_model.dart';

class UserAuthenticationService {
  static const String serverUrl =
      NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  final BaseNetworkService service = BaseNetworkService();

  static const String _getUser = "/user";

  Future<bool> loginUser(String username, String password) async {
    const String path = '/login';
    final LoginDTORequest loginRequest = LoginDTORequest(
      username: username,
      password: password,
    );

    ServiceResponse response =
        await service.sendRequestSafe<LoginDTORequest, LoginDTOResponse>(
      path,
      loginRequest,
      LoginDTOResponse(),
      'POST',
    );

    if (response.success) {
      return true;
    } else {
      print('Login failed - Status Code: ${response.errorMessage}');
      return false;
    }

    const loginUrl = '$serverUrl/login';

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

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

      final response = await http.post(
        Uri.parse('$serverUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<bool> forgotPassword(String username, String email) async {
    try {
      final body = jsonEncode({
        'username': username,
        'password': email,
      });

      final response = await http.post(
        Uri.parse('$serverUrl/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Get the current user
  Future<User?> getCurrentUser(String? username) async {
    ServiceResponse response =
        await service.sendRequestSafe<UserDTOResponse, UserDTOResponse>(
      _getUser,
      null,
      UserDTOResponse(),
      'GET',
    );

    if (response.success) {
      UserDTOResponse userResponse = response.responseConverted;
      User user = User(
        name: userResponse.name,
        surname: userResponse.surname,
        email: userResponse.email,
        username: userResponse.username,
        profileImage: userResponse.profileImage,
      );
      return user;
    } else {
      print('User not found - Status Code: ${response.errorMessage}');
      return null;
    }
  }
}
