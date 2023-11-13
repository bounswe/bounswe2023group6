import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';

class LFGPage extends StatelessWidget {
  LFGPage({super.key});

  final _likes = [
    ["World of Warcraft", "3/4", "8"],
    ["Apex Legends", "2/5", "3"],
    ["Borderlands 3", "1/3", "1"],
    ["Destiny 2", "'2/3", "7"],
    ["Fortnite", "1/3", "2"],
  ];

  final _userlist = [
    "GamerXplorer • 8hr",
    "EpicQuestMaster • 2hr",
    "MysticalMage • 25min",
    "PixelAdventurer • 5hr",
    "GalaxySeeker • 12min",
  ];

  final _contentlist = [
    "Hey, fellow adventurers! I'm on the lookout for a dedicated group to conquer a Mythic Dungeon in World of Warcraft. Tank, DPS, and healers, we need you! Let's tackle the challenges and reap the epic loot together. Add me and let's embark on this epic journey! ",
    "Calling all Apex Legends champions! We're forming a squad for some intense battles. If you're skilled, strategic, and ready for action, join us. We need a Wraith main and a sharpshooting Mirage. Let's dominate the arena and claim victory!",
    "Vault Hunters, unite! I'm itching for some co-op action in Borderlands 3. Whether you're a Siren, a Beastmaster, or a Gunner, we've got room for one more in our party. Let's loot, shoot, and plunder the galaxy together!",
    "Guardians, assemble! We're forming a fireteam to tackle the most challenging Destiny 2 raids. We need experienced players who can handle the toughest battles the solar system can throw at us. Join us, and let's conquer the darkness! ",
    "Ready to secure that Victory Royale in Fortnite? I'm searching for a skilled partner for some epic duos. If you can build, shoot, and adapt on the fly, we'll make an unbeatable duo. Let's drop into the action and conquer the battlefield.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Game Lounge"),
        drawer: const CustomDrawer(),
        body: ListView(
          children: [
            for (var i = 0; i < 5; i++)
              LFGCard(
                content: _contentlist[i],
                userdata: _userlist[i],
                likes: _likes[i],
              ),
          ],
        ));
  }
}

class LFGCard extends StatelessWidget {
  final String content;
  final String userdata;
  final List likes;

  const LFGCard({
    super.key,
    required this.content,
    required this.userdata,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(userdata,
                            style: const TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
                const Center(child: SizedBox()),
                Text(content,
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 150,
                        child: Text(
                          likes[0],
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        )),
                    Text(likes[1],
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        const Icon(Icons.comment),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(likes[2],
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
