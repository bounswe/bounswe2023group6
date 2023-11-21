import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/post_model.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoggedIn = true;

  List<Post> posts = [
    Post(
      createdDate: DateTime.now().subtract(const Duration(hours: 2)),
      id: 1,
      title: 'Epic Battles: The Saga',
      userId: 1,
      content:
          "Hey, fellow gamers! Just stumbled upon the latest trailer for 'Epic Battles: The Saga,' and I'm mind-blown! The graphics are absolutely jaw-dropping, and the gameplay looks like a total adrenaline rush. I can't wait to get my hands on this game and dive into epic battles of galactic proportions. What are your thoughts? Is",
      username: "GamerXplorer",
      likes: 23,
      dislikes: 2,
      comments: 8,
    ),
    Post(
      createdDate: DateTime.now().subtract(const Duration(days: 1)),
      id: 2,
      title: 'Galactic Explorers',
      userId: 2,
      username: "EpicQuestMaster",
      content:
          "After weeks of traversing the cosmos, I've finally completed 'Galactic Explorers,' and I'm here to share my thoughts. This game is a true cosmic adventure with its vast open-world, stunning visuals, and a captivating storyline. From epic space battles to discovering new alien civilizations",
      likes: 11,
      dislikes: 1,
      comments: 3,
    ),
    Post(
      createdDate: DateTime.now().subtract(const Duration(days: 2)),
      id: 3,
      title: "Secrets of the Lost Realms",
      userId: 3,
      username: "MysticalMage",
      content:
          "I heard a rumor that has it that a mysterious new game, 'Secrets of the Lost Realms,' is in the works. While details are scarce, the anticipation is building ...",
      likes: 5,
      dislikes: 0,
      comments: 1,
    ),
    Post(
      createdDate: DateTime.now().subtract(const Duration(hours: 5)),
      id: 4,
      title: 'Captain Thunderstrike in Heroes of Valor',
      userId: 4,
      username: "PixelAdventurer",
      content:
          "Heroes come in all forms, but today, let's talk about the charismatic and valiant Captain Thunderstrike from 'Heroes of Valor.' This knight in shining armor ... ",
      likes: 19,
      dislikes: 1,
      comments: 17,
    ),
    Post(
      createdDate: DateTime.now().subtract(const Duration(minutes: 12)),
      id: 5,
      title: "Mystic Runes: Enchanted Quest",
      userId: 5,
      username: "GalaxySeeker",
      content:
          "Calling all mystic rune enthusiasts! If you're knee-deep in 'Mystic Runes: Enchanted Quest,' here's a pro tip for you. Combine the Fire Rune with the Wind ...",
      likes: 3,
      dislikes: 0,
      comments: 2,
    ),
    Post(
      createdDate: DateTime.now().subtract(const Duration(hours: 16)),
      id: 6,
      title: 'PixelCon 2023 is coming!',
      userId: 6,
      username: "NinjaPlayer27",
      content:
          "Attention all gamers, mark your calendars because 'PixelCon 2023' is just around the corner! Get ready for the ultimate gaming extravaganza filled with ...",
      likes: 27,
      dislikes: 3,
      comments: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: TextConstants.titleText),
        drawer: const CustomDrawer(),
        body: ListView(
          children: [
            for (var i = 0; i < 6; i++) PostCard(post: posts[i]),
          ],
        ));
  }
}
