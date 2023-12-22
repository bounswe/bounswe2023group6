import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';
import 'package:mobile/data/models/dto/register/register_request.dart';
import 'package:mobile/data/models/dto/register/register_response.dart';
import 'package:mobile/data/models/dto/user/user_detailed_response.dart';
import 'package:mobile/data/models/dto/user/user_response.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/utils/shared_manager.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'dart:convert';
import '../../data/models/user_model.dart';

class UserAuthenticationService {
  static const String serverUrl =
      NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  final BaseNetworkService service = BaseNetworkService();

  CacheManager cacheManager = CacheManager();

  static const String _getUser = "/user";
  static const String _getUserDetails = "/user_details";
  static const String _login = "/login";
  static const String _register = "/register";

  Future<bool> loginUser(String username, String password) async {

    final LoginDTORequest loginRequest = LoginDTORequest(
      username: username,
      password: password,
    );

    ServiceResponse response =
        await service.sendRequestSafe<LoginDTORequest, LoginDTOResponse>(
      _login,
      loginRequest,
      LoginDTOResponse(),
      'POST',
    );

    if (response.success) {
      String? sessionId =
          response.response?.headers['set-cookie']?.first.split(";").first.split("=")[1].split(",").first;
      print(sessionId); 
      cacheManager.saveSessionId(sessionId);
      return true;
    } else {
      print('Login failed - Status Code: ${response.errorMessage}');
      return false;
    }
  }

  Future<bool> registerUser(String username, String password, String email) async {
    Map<String, String> request = {
      'username': username,
      'password': password,
      'email': email,
      'name': "dummy",
      'surname': "dummy"
    };
    var formData = FormData.fromMap({
      'request': MultipartFile.fromString(
        jsonEncode(request),
        contentType: MediaType("application", "json"),
      ),
    });
    Response response = await Dio().post(
      '$serverUrl/register',
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('register failed - Status Code: ${response.statusCode}');
      return false;
    }
  }

  // Log out the current user
  Future<void> logout() async {
      cacheManager.removeSessionId();
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
}
