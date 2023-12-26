import 'package:dio/dio.dart';
import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/dto/content/single_content_dto_response.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/lfg/lfg_create_dto_request.dart';
import 'package:mobile/data/models/dto/lfg/lfg_response.dart';
import 'package:mobile/data/models/dto/lfg/mutliple_lfg_dto_request.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';
import 'package:mobile/utils/shared_manager.dart';

class LFGService {
  static const String serverUrl = NetworkConstants.BASE_LOCAL_URL;

  final BaseNetworkService service = BaseNetworkService();

  static const String _getLFGs = "/lfg/all";
  static const String _getLikedUsers = "/lfg/likes";
  static const String _getDislikedUsers = "/lfg/dislikes";

  static List<LFG> lfgList = [
    LFG(
      creationDate: DateTime.now().subtract(const Duration(hours: 2)),
      id: 1,
      title: 'World of Warcraft',
      description:
          "Hey, fellow adventurers! I'm on the lookout for a dedicated group to conquer a Mythic Dungeon in World of Warcraft. Tank, DPS, and healers, we need you! Let's tackle the challenges and reap the epic loot together. Add me and let's embark on this epic journey! ",
      requiredPlatform: "XBOX",
      requiredLanguage: "EN",
      micCamRequirement: true,
      memberCapacity: 15,
      tags: ["tag1"],
      ownerUserId: 1,
      ownerUsername: 'GamerXplorer',
      ownerProfileImage: '',
      likes: 23,
      dislikes: 2,
      relatedGameId: 1,
      comments: 8,
    ),
    LFG(
      creationDate: DateTime.now().subtract(const Duration(days: 1)),
      id: 2,
      title: 'World of Warcraft',
      description:
          "Calling all Apex Legends champions! We're forming a squad for some intense battles. If you're skilled, strategic, and ready for action, join us. We need a Wraith main and a sharpshooting Mirage. Let's dominate the arena and claim victory!",
      requiredPlatform: "XBOX",
      requiredLanguage: "EN",
      micCamRequirement: true,
      memberCapacity: 15,
      tags: ["tag1"],
      ownerUserId: 2,
      ownerUsername: 'EpicQuestMaster',
      ownerProfileImage: '',
      likes: 11,
      dislikes: 1,
      relatedGameId: 2,
      comments: 3,
    ),
    LFG(
      creationDate: DateTime.now().subtract(const Duration(days: 2)),
      id: 3,
      title: "World of Warcraft",
      description:
          "Vault Hunters, unite! I'm itching for some co-op action in Borderlands 3. Whether you're a Siren, a Beastmaster, or a Gunner, we've got room for one more in our party. Let's loot, shoot, and plunder the galaxy together!",
      requiredPlatform: "XBOX",
      requiredLanguage: "EN",
      micCamRequirement: true,
      memberCapacity: 15,
      tags: ["tag1"],
      ownerUserId: 3,
      ownerUsername: 'MysticalMage',
      ownerProfileImage: '',
      likes: 5,
      dislikes: 0,
      relatedGameId: 3,
      comments: 1,
    ),
    LFG(
      creationDate: DateTime.now().subtract(const Duration(hours: 5)),
      id: 4,
      title: 'World of Warcraft',
      description:
          "Guardians, assemble! We're forming a fireteam to tackle the most challenging Destiny 2 raids. We need experienced players who can handle the toughest battles the solar system can throw at us. Join us, and let's conquer the darkness! ",
      requiredPlatform: "XBOX",
      requiredLanguage: "EN",
      micCamRequirement: true,
      memberCapacity: 15,
      tags: ["tag1"],
      ownerUserId: 4,
      ownerUsername: 'PixelAdventurer',
      ownerProfileImage: '',
      likes: 19,
      dislikes: 1,
      relatedGameId: 4,
      comments: 17,
    ),
    LFG(
      creationDate: DateTime.now().subtract(const Duration(days: 3)),
      id: 5,
      title: 'World of Warcraft',
      description:
          "Ready to secure that Victory Royale in Fortnite? I'm searching for a skilled partner for some epic duos. If you can build, shoot, and adapt on the fly, we'll make an unbeatable duo. Let's drop into the action and conquer the battlefield.",
      requiredPlatform: "XBOX",
      requiredLanguage: "EN",
      micCamRequirement: true,
      memberCapacity: 15,
      tags: ["tag1"],
      ownerUserId: 5,
      ownerUsername: 'GamerXplorer',
      ownerProfileImage: '',
      likes: 23,
      dislikes: 2,
      relatedGameId: 5,
      comments: 8,
    ),
  ];

  Future<List<LFG>> getLFGs() async {
    if (NetworkConstants.useMockData) {
      return getLfgDataList();
    } else {

      ServiceResponse<MultipleLFGAsDTO> response =
          await service.sendRequestSafe<EmptyResponse, MultipleLFGAsDTO>(
        _getLFGs,
        EmptyResponse(),
        MultipleLFGAsDTO(),
        'GET',
      );
      if (response.success) {
        List<LFG> lfgs =
            response.responseConverted!.lfgs!.map((e) => e.lfg!).toList();
        return lfgs;
      } else {
        throw Exception('Failed to load lfgs');
      }
    }
  }

  Future<LFG> getLFG(int lfgId) async {
    if (NetworkConstants.useMockData) {
      return getLfgDataList()[lfgId - 1];
    } 

    ServiceResponse<LFGDTOResponse> response =
        await service.sendRequestSafe<EmptyResponse, LFGDTOResponse>(
      "/lfg/$lfgId",
      null,
      LFGDTOResponse(),
      'GET',
    );

    if (response.success) {
      LFG lfg = response.responseConverted!.lfg!;
      return lfg;
    } else {
      throw Exception('Failed to load lfg');
    }
  }

  Future<Comment> createComment(
      int lfgId, String commentContent, int? parentContentId) async {
    return Comment(
      id: 1,
      content: commentContent,
      ownerUserId: 1,
      ownerUsername: 'user1',
      ownerProfileImage: '',
      createdDate: DateTime.now(),
      likes: 0,
      dislikes: 0,
      parentContentId: parentContentId,
    );
  }

  Future<List<int>> getLikedUsers(int lfgId) async {
    return [1, 2, 3];
  }

  Future<List<int>> getDislikedUsers(int lfgId) async {
    return [4, 5, 6];
  }

  static LFG getGameStatic(int id) {
    return getLfgDataList()[id];
  }

  static List<LFG> getLfgDataList() {
    return lfgList;
  }

  Future<bool> createLFG(
    String title,
    String description,
    String requiredPlatform,
    String requiredLanguage,
    bool micCamRequirement,
    int memberCapacity,
    int? gameId,
    List<String> tags,
  ) async {
    if (NetworkConstants.useMockData) {
      lfgList.add(LFG(
        creationDate: DateTime.now().subtract(const Duration(hours: 5)),
        id: lfgList.length + 1,
        title: title,
        description: description,
        requiredPlatform: requiredPlatform,
        requiredLanguage: requiredLanguage,
        micCamRequirement: micCamRequirement,
        memberCapacity: memberCapacity,
        tags: ["tag1"],
        ownerUserId: 5,
        ownerUsername: 'GamerXplorer',
        ownerProfileImage: '',
        likes: 23,
        dislikes: 2,
        relatedGameId: 5,
        comments: 8,
      ));
      return true;
    } else {
      LFGCreateDTORequest request = LFGCreateDTORequest(
        title: title,
        description: description,
        requiredPlatform: requiredPlatform,
        requiredLanguage: requiredLanguage,
        micCamRequirement: micCamRequirement,
        memberCapacity: memberCapacity,
        gameId: gameId,
        tags: tags,
      );

      Map<String, dynamic> jsonData = request.toJson();

      final response =
          await service.sendRequestSafe<LFGCreateDTORequest, EmptyResponse>(
        "/lfg",
        request,
        EmptyResponse(),
        'POST',
      );
      if (response.success) {
        return true;
      } else {
        throw Exception('Failed to create lfg.');
      }
    }
  }

  Future<bool> joinLfg(int lfgId) async {

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/lfg/$lfgId/join",
      null,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to cancel post');
    }

  }

  Future<bool> leaveLfg(int lfgId) async {

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/lfg/$lfgId/leave",
      null,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to cancel post');
    }

  }

  Future<bool> kickLfgUser(int lfgId, int userId) async {

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "/lfg/$lfgId/kick/$userId",
      null,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to cancel post');
    }

  }


  static const String _getRecommendedLfgs = "/lfg/recommended";

  Future<List<LFG>> getRecommendedLFGs() async {
    ServiceResponse<MultipleLFGAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleLFGAsDTO>(
      _getRecommendedLfgs,
      EmptyResponse(),
      MultipleLFGAsDTO(),
      'GET',
    );

    if (response.success) {
      List<LFG> lfgs =
          response.responseConverted!.lfgs!.map((e) => e.lfg!).toList();
      if (lfgs.isEmpty) {
        lfgs = await getLFGs();
      }
      
      return lfgs;
    } else {
      throw Exception('Failed to load lfgs');
    }
  }
  
}
