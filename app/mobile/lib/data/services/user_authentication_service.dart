import 'package:http/http.dart' as http;
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/login/login_request.dart';
import 'package:mobile/data/models/dto/login/login_response.dart';
import 'package:mobile/data/models/dto/user/user_detailed_response.dart';
import 'package:mobile/data/models/dto/user/user_response.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'dart:convert';
import '../../data/models/user_model.dart';

class UserAuthenticationService {
  static const String serverUrl =
      NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  final BaseNetworkService service = BaseNetworkService();

  static const String _getUser = "/user";
  static const String _getUserDetails = "/user_details";

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

  void loadMockData(User user) {
    user.about =
        "Hey there, I'm Ayse, and I'm a huge game enthusiast. Ever since I was a kid, video games have been a major part of my life. From the first time I picked up a controller, I was hooked. I spent countless hours playing my favorite games, immersing myself in their worlds, and trying to master their mechanics.";
    user.likedPosts = [
      Post(
        id: 1,
        title: 'Post 1',
        userId: 1,
        content:
            "Hey, fellow gamers! Just stumbled upon the latest trailer for 'Epic Battles: The Saga,' and I'm mind-blown! The graphics are absolutely jaw-dropping, and the gameplay looks like a total adrenaline rush. I can't wait to get my hands on this game and dive into epic battles of galactic proportions. What are your thoughts? Is",
        username: "GamerXplorer • 8hr",
        likes: 23,
        dislikes: 2,
        comments: 8,
      ),
      Post(
        id: 2,
        title: 'Post 2',
        userId: 2,
        username: "EpicQuestMaster • 2hr",
        content:
            "After weeks of traversing the cosmos, I've finally completed 'Galactic Explorers,' and I'm here to share my thoughts. This game is a true cosmic adventure with its vast open-world, stunning visuals, and a captivating storyline. From epic space battles to discovering new alien civilizations",
        likes: 11,
        dislikes: 1,
        comments: 3,
      ),
      Post(
        id: 3,
        title: 'Post 3',
        userId: 3,
        username: "GamerXplorer • 8hr",
        content:
            "Hey, fellow gamers! Just stumbled upon the latest trailer for 'Epic Battles: The Saga,' and I'm mind-blown! The graphics are absolutely jaw-dropping, and the gameplay looks like a total adrenaline rush. I can't wait to get my hands on this game and dive into epic battles of galactic proportions. What are your thoughts? Is",
        likes: 23,
        dislikes: 2,
        comments: 8,
      ),
    ];
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
