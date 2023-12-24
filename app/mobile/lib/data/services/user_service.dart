import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/dto/content/multiple_content_dto_response.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/game/multiple_game_dto_response.dart';
import 'package:mobile/data/models/dto/user/multiple_user_as_dto.dart';
import 'package:mobile/data/models/dto/user/user_response.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/base_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/utils/shared_manager.dart';

class UserService {
  BaseNetworkService service = BaseNetworkService();

  UserService._init();
  static final UserService _instance = UserService._init();

  factory UserService() => _instance;
  static UserService get instance => _instance;

  static const String _getUser = '/user';
  static const String _updateUser = '/user';
  static const String _getCreatedPosts = '/user/created-posts';
  static const String _getCreatedGames = '/user/created-games';
  static const String _getLikedPosts = '/user/liked-posts';
  static const String _getLikedGames = '/user/liked-games';
  static const String _getLikedComments = '/user/liked-comments';
  static const String _followUser = '/user/follow-user';
  static const String _unfollowUser = '/user/unfollow-user';
  static const String _getFollowings = '/user/get-followings';

  Future<User> getUser(String username) async {
    ServiceResponse<UserDTOResponse> response =
        await service.sendRequestSafe<EmptyResponse, UserDTOResponse>(
      "$_getUser/$username",
      null,
      UserDTOResponse(),
      'GET',
    );

    if (response.success) {
      return response.responseConverted!.user!;
    } else {
      throw Exception('Failed to load user ${response.errorMessage}');
    }
  }

  Future<bool> updateUser(User user, {String? imageFilePath}) async {
    final SharedManager manager = SharedManager();
    if (!manager.checkString(SharedKeys.sessionId)) {
      throw Exception('Session id is null');
    }
    String sessionID = manager.getString(SharedKeys.sessionId);

    Map<String, dynamic> request = user.toJson();
    var formData = FormData.fromMap({
      'request': MultipartFile.fromString(
        jsonEncode(request),
        contentType: MediaType("application", "json"),
      ),
      if (imageFilePath != null)
        'image': await MultipartFile.fromFile(imageFilePath)
    });

    Response response = await Dio().post(
      service.options.baseUrl + _updateUser,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Cookie': 'SESSIONID=$sessionID'
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<List<Post>> getCreatedPosts(int userId) async {
    ServiceResponse<MultipleContentAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleContentAsDTO>(
      "$_getCreatedPosts/$userId",
      null,
      MultipleContentAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Post> posts = response.responseConverted!.posts!
          .map((e) => e.content! as Post)
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load posts ${response.errorMessage}');
    }
  }

  Future<List<Game>> getCreatedGames(int userId) async {
    ServiceResponse<MultipleGameAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleGameAsDTO>(
      "$_getCreatedGames/$userId",
      null,
      MultipleGameAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Game> games =
          response.responseConverted!.games!.map((e) => e.game!).toList();

      return games;
    } else {
      throw Exception('Failed to load posts ${response.errorMessage}');
    }
  }

  Future<List<Post>> getLikedPosts(int userId) async {
    ServiceResponse<MultipleContentAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleContentAsDTO>(
      "$_getLikedPosts/$userId",
      null,
      MultipleContentAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Post> posts = response.responseConverted!.posts!
          .map((e) => e.content! as Post)
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load posts ${response.errorMessage}');
    }
  }

  Future<List<Comment>> getLikedComments(String username) async {
    ServiceResponse<MultipleContentAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleContentAsDTO>(
      "$_getLikedComments/$username",
      null,
      MultipleContentAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Comment> posts = response.responseConverted!.posts!
          .map((e) => e.content! as Comment)
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load posts ${response.errorMessage}');
    }
  }

  Future<void> getUserDetails(User user) async {
    if (NetworkConstants.useMockData) {
      loadMockData(user);
    }
    user.createdPosts = await getCreatedPosts(user.userId);
    user.likedPosts = await getLikedPosts(user.userId);
    user.createdGames = await getCreatedGames(user.userId);
    // user.likedGames = await getLikedGames();
  }

  Future<void> followUser(User user) async {
    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_followUser/${user.userId}",
      null,
      EmptyResponse(),
      'PUT',
    );

    if (!response.success) {
      throw Exception('Failed to follow user ${response.errorMessage}');
    }
  }

  Future<void> unfollowUser(User user) async {
    ServiceResponse<EmptyResponse> response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_unfollowUser/${user.userId}",
      null,
      EmptyResponse(),
      'PUT',
    );

    if (!response.success) {
      throw Exception('Failed to unfollow user ${response.errorMessage}');
    }
  }

  Future<List<User>> getFollowings() async {
    ServiceResponse<MultipleUserAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleUserAsDTO>(
      _getFollowings,
      null,
      MultipleUserAsDTO(),
      'GET',
    );

    if (response.success) {
      List<User> users =
          response.responseConverted!.users!.map((e) => e.user!).toList();
      return users;
    } else {
      throw Exception('Failed to load followings ${response.errorMessage}');
    }
  }

  void loadMockData(User user) async {
    user.about =
        "Hey there, I'm Ayse, and I'm a huge game enthusiast. Ever since I was a kid, video games have been a major part of my life. From the first time I picked up a controller, I was hooked. I spent countless hours playing my favorite games, immersing myself in their worlds, and trying to master their mechanics.";
    user.likedPosts = await PostService().getPosts();
    user.likedGames = [
      Game(
          gameId: 1,
          description:
              "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
          title: "Witcher 3",
          gamePicture:
              "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"),
      Game(
          gameId: 2,
          description:
              "The Witcher 3: Wild Hunt, CD Projekt RED tarafından geliştirilen ve yayımlanan aksiyon rol yapma oyunudur. The Witcher serisinin üçüncü oyunu olan yapım, The Witcher 2: Assassins of Kings'in devamı niteliğindedir. Oyun, 19 Mayıs 2015'te Microsoft Windows, PlayStation 4 ve Xbox One için piyasaya sürülmüştür. Nintendo Switch sürümü 15 Ekim 2019'da yayımlanmıştır. Oyun, 2015 yılında 250'den fazla yılın oyun ödülünü kazanmıştır.",
          title: "Witcher 3",
          gamePicture:
              "https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"),
    ];
  }
}
