import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/services/base_service.dart';

class LFGService {
  static const String serverUrl = NetworkConstants.BASE_LOCAL_URL;

  final BaseNetworkService service = BaseNetworkService();

  static const String _getLFGs = "/lfg";

  static List<LFG> lfgList =[
      LFG(
          lfgId: 1,
          title: "World of Warcraft",
          description:
              "Hey, fellow adventurers! I'm on the lookout for a dedicated group to conquer a Mythic Dungeon in World of Warcraft. Tank, DPS, and healers, we need you! Let's tackle the challenges and reap the epic loot together. Add me and let's embark on this epic journey! ",
          ),
      LFG(
          lfgId: 2,
          title: "World of Warcraft",
          description:
              "Calling all Apex Legends champions! We're forming a squad for some intense battles. If you're skilled, strategic, and ready for action, join us. We need a Wraith main and a sharpshooting Mirage. Let's dominate the arena and claim victory!",
          ),
      LFG(
          lfgId: 3,
          title: "World of Warcraft",
          description:
              "Vault Hunters, unite! I'm itching for some co-op action in Borderlands 3. Whether you're a Siren, a Beastmaster, or a Gunner, we've got room for one more in our party. Let's loot, shoot, and plunder the galaxy together!",
          ),
      LFG(
          lfgId: 4,
          title: "World of Warcraft",
          description:
              "Guardians, assemble! We're forming a fireteam to tackle the most challenging Destiny 2 raids. We need experienced players who can handle the toughest battles the solar system can throw at us. Join us, and let's conquer the darkness! ",
          ),
      LFG(
          lfgId: 5,
          title: "World of Warcraft",
          description:
              "Ready to secure that Victory Royale in Fortnite? I'm searching for a skilled partner for some epic duos. If you can build, shoot, and adapt on the fly, we'll make an unbeatable duo. Let's drop into the action and conquer the battlefield.",
          )
    ];

  Future<List<LFG>> getLFGs() async {
    return getLfgDataList();
  }

  Future<LFG> getLFG(int lfgId) async {
    return getLfgDataList()[lfgId - 1];
  }

  Future<void> createComment (int lfgId) async {
    
  }


  static LFG getGameStatic(int id) {
    return getLfgDataList()[id];
  }

  static List<LFG> getLfgDataList() {
    return lfgList;
  }

}

