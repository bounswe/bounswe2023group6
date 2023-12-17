import 'package:flutter/material.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import 'package:mobile/presentation/widgets/lfg_card_widget.dart';

class GridViewState extends State {
  int countValue = 2;
  int aspectWidth = 2;
  int aspectHeight = 1;
  List<LFG> itemList = getImageDataList();

  static List<LFG> getImageDataList() {
    return [
      LFG(
          lfgId: 1,
          title: "World of Warcraft",
          description:
              "Hey, fellow adventurers! I'm on the lookout for a dedicated group to conquer a Mythic Dungeon in World of Warcraft. Tank, DPS, and healers, we need you! Let's tackle the challenges and reap the epic loot together. Add me and let's embark on this epic journey! ",
          user: "GamerXplorer • 8hr"),
      LFG(
          lfgId: 2,
          title: "World of Warcraft",
          description:
              "Calling all Apex Legends champions! We're forming a squad for some intense battles. If you're skilled, strategic, and ready for action, join us. We need a Wraith main and a sharpshooting Mirage. Let's dominate the arena and claim victory!",
          user: "EpicQuestMaster • 2hr"),
      LFG(
          lfgId: 3,
          title: "World of Warcraft",
          description:
              "Vault Hunters, unite! I'm itching for some co-op action in Borderlands 3. Whether you're a Siren, a Beastmaster, or a Gunner, we've got room for one more in our party. Let's loot, shoot, and plunder the galaxy together!",
          user: "MysticalMage • 25min"),
      LFG(
          lfgId: 4,
          title: "World of Warcraft",
          description:
              "Guardians, assemble! We're forming a fireteam to tackle the most challenging Destiny 2 raids. We need experienced players who can handle the toughest battles the solar system can throw at us. Join us, and let's conquer the darkness! ",
          user: "PixelAdventurer • 5hr"),
      LFG(
          lfgId: 5,
          title: "World of Warcraft",
          description:
              "Ready to secure that Victory Royale in Fortnite? I'm searching for a skilled partner for some epic duos. If you can build, shoot, and adapt on the fly, we'll make an unbeatable duo. Let's drop into the action and conquer the battlefield.",
          user: "GalaxySeeker • 12min")
    ];
  }

  changeMode() {
    if (countValue == 2) {
      setState(() {
        countValue = 1;
        aspectWidth = 3;
        aspectHeight = 1;
      });
    } else {
      setState(() {
        countValue = 2;
        aspectWidth = 2;
        aspectHeight = 1;
      });
    }
  }

  getGridViewSelectedItem(BuildContext context, LFG gridItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
          title: gridItem.likes![0],
          content: gridItem.content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: GridView.count(
          crossAxisCount: countValue,
          childAspectRatio: (aspectWidth / aspectHeight),
          children: itemList
              .map((data) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/group",);
                  },
                  child: LFGCard(lfg: data)))
              .toList(),
        ),
      )
    ]));
  }
}
