import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/services/base_service.dart';

class LFGService {
  static const String serverUrl = NetworkConstants.BASE_LOCAL_URL;

  final BaseNetworkService service = BaseNetworkService();

  static const String _getLFGs = "/lfg";
  static const String _getLikedUsers = "/lfg/likes";
  static const String _getDislikedUsers = "/lfg/dislikes";
  static const String _getComments = "/lfg/comments";

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
    return getLfgDataList();
  }

  Future<LFG> getLFG(int lfgId) async {
    return getLfgDataList()[lfgId - 1];
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
}
