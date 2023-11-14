import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/post_model.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  var isLoggedIn = true;

  List<Post> posts = [
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
      username: "MysticalMage • 25min",
      content:
          "I heard a rumor that has it that a mysterious new game, 'Secrets of the Lost Realms,' is in the works. While details are scarce, the anticipation is building ...",
      likes: 5,
      dislikes: 0,
      comments: 1,
    ),
    Post(
      id: 4,
      title: 'Post 4',
      userId: 4,
      username: "PixelAdventurer • 5hr",
      content:
          "Heroes come in all forms, but today, let's talk about the charismatic and valiant Captain Thunderstrike from 'Heroes of Valor.' This knight in shining armor ... ",
      likes: 19,
      dislikes: 1,
      comments: 17,
    ),
    Post(
      id: 5,
      title: 'Post 5',
      userId: 5,
      username: "GalaxySeeker • 12min",
      content:
          "Calling all mystic rune enthusiasts! If you're knee-deep in 'Mystic Runes: Enchanted Quest,' here's a pro tip for you. Combine the Fire Rune with the Wind ...",
      likes: 3,
      dislikes: 0,
      comments: 2,
    ),
    Post(
      id: 6,
      title: 'Post 6',
      userId: 6,
      username: "NinjaPlayer27 • 16hr",
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
