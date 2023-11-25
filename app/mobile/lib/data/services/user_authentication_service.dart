import 'package:http/http.dart' as http;
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

  CacheManager? cacheManager;

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
      final SharedManager manager = SharedManager();
      await manager.init();
      cacheManager = CacheManager(manager);
      cacheManager!.saveSessionId(sessionId);
      return true;
    } else {
      print('Login failed - Status Code: ${response.errorMessage}');
      return false;
    }
  }

  Future<bool> registerUser(String username, String password, String email) async {
    final RegisterDTORequest registerRequest = RegisterDTORequest(
      username: username,
      password: password,
      email: email,
      name: "dummy",
      surname: "dummy"
    );

    ServiceResponse response =
        await service.sendRequestSafe<RegisterDTORequest, RegisterDTOResponse>(
      _register,
      registerRequest,
      RegisterDTOResponse(),
      'POST',
    );

    if (response.success) {
      return true;
    } else {
      print('register failed - Status Code: ${response.errorMessage}');
      return false;
    }
  }

  // Log out the current user
  Future<void> logout() async {
      final SharedManager manager = SharedManager();
      await manager.init();
      cacheManager = CacheManager(manager);
      cacheManager!.removeSessionId();
      
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
      "$_getUser/$username",
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

  Future<void> getUserDetails(User user) async {
    ServiceResponse response = await service
        .sendRequestSafe<UserDetailedDTOResponse, UserDetailedDTOResponse>(
      "$_getUserDetails/${user.username}",
      null,
      UserDetailedDTOResponse(),
      'GET',
    );

    if (response.success) {
      UserDetailedDTOResponse userResponse = response.responseConverted;
      user.about = userResponse.about;
      // user.likedPosts = userResponse.likedPosts;
      // user.savedPosts = userResponse.savedPosts;
      // user.createdPosts = userResponse.createdPosts;
      // user.commentedPosts = userResponse.commentedPosts;
      // user.reportedPosts = userResponse.reportedPosts;
      // user.blockedPosts = userResponse.blockedPosts;
      // user.likedGames = userResponse.likedGames;
      // user.savedGames = userResponse.savedGames;
      if (NetworkConstants.useMockData) {
        loadMockData(user);
      }
    } else {
      print('User not found - Status Code: ${response.errorMessage}');
      loadMockData(user);
    }
  }

  void loadMockData(User user) async {
    user.about =
        "Hey there, I'm Ayse, and I'm a huge game enthusiast. Ever since I was a kid, video games have been a major part of my life. From the first time I picked up a controller, I was hooked. I spent countless hours playing my favorite games, immersing myself in their worlds, and trying to master their mechanics.";
    user.likedPosts = await PostService().getPosts();
    user.likedGames = [
      Game(
          id: 1,
          description:
              "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
          name: "Witcher 3",
          imageLink:
              "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"),
      Game(
          id: 2,
          description:
              "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
          name: "Witcher 3",
          imageLink:
              "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"),
    ];
  }
}
