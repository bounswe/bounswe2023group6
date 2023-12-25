import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/dto/content/multiple_content_dto_response.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/game/multiple_game_dto_response.dart';
import 'package:mobile/data/models/dto/search/search_all_response.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/lfg_service.dart';

class SearchService {
  BaseNetworkService service = BaseNetworkService();

  SearchService._init();
  static final SearchService _instance = SearchService._init();

  factory SearchService() => _instance;
  static SearchService get instance => _instance;

  static const String _searchAll = '/search/all';
  static const String _searchPosts = '/search/posts';
  static const String _searchGames = '/search/games';
  static const String _searchUsers = '/search/lfgs';

  Future<Map<String, List<dynamic>>> searchAll(String query) async {
    ServiceResponse<SearchAllResponse> response =
        await service.sendRequestSafe<EmptyResponse, SearchAllResponse>(
      "$_searchAll?query=$query",
      null,
      SearchAllResponse(),
      'GET',
    );

    if (response.success) {
      List<Post> posts = response.responseConverted!.posts!;
      List<Game> games = response.responseConverted!.games!;
      // TODO: add lfgs later
      // List<LFG> lfgs = response.responseConverted!.lfgs!;
      List<LFG> lfgs = [];

      return {
        'posts': posts,
        'games': games,
        'lfgs': lfgs,
      };
    } else {
      throw Exception('Failed to load posts ${response.errorMessage}');
    }
  }

  Future<List<Post>> searchPosts(String query) async {
    ServiceResponse<MultipleContentAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleContentAsDTO>(
      "$_searchPosts?query=$query",
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

  Future<List<Game>> searchGames(String query) async {
    ServiceResponse<MultipleGameAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleGameAsDTO>(
      "$_searchGames?query=$query",
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

  Future<List<LFG>> searchLFGs(String query) async {
    ServiceResponse<MultipleContentAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleContentAsDTO>(
      "$_searchUsers?query=$query",
      null,
      MultipleContentAsDTO(),
      'GET',
    );

    if (response.success) {
      List<LFG> lfgs = response.responseConverted!.posts!
          .map((e) => e.content! as LFG)
          .toList();

      return lfgs;
    } else {
      throw Exception('Failed to load posts ${response.errorMessage}');
    }
  }
}
