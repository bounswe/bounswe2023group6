import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoggedIn = true;

  final _likes = [
    ["23","2","8"],
    ["11","1","3"],
    ["5","0","1"],
    ["19","1","17"],
    ["3","0","2"],
    ["27","3","10"],
  ];

  final _userlist = [
    "GamerXplorer • 8hr",
    "EpicQuestMaster • 2hr",
    "MysticalMage • 25min",
    "PixelAdventurer • 5hr",
    "GalaxySeeker • 12min",
    "NinjaPlayer27 • 16hr",
  ];

  final _contentlist = [
    "Hey, fellow gamers! Just stumbled upon the latest trailer for 'Epic Battles: The Saga,' and I'm mind-blown! The graphics are absolutely jaw-dropping ...",
    "After weeks of traversing the cosmos, I've finally completed 'Galactic Explorers,' and I'm here to share my thoughts. This game is a true cosmic ...",
    "I heard a rumor that has it that a mysterious new game, 'Secrets of the Lost Realms,' is in the works. While details are scarce, the anticipation is building ...",
    "Heroes come in all forms, but today, let's talk about the charismatic and valiant Captain Thunderstrike from 'Heroes of Valor.' This knight in shining armor ... ",
    "Calling all mystic rune enthusiasts! If you're knee-deep in 'Mystic Runes: Enchanted Quest,' here's a pro tip for you. Combine the Fire Rune with the Wind ...",
    "Attention all gamers, mark your calendars because 'PixelCon 2023' is just around the corner! Get ready for the ultimate gaming extravaganza filled with ..."
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(title: TextConstants.titleText),
      drawer: const CustomDrawer(),
      body:ListView(
        children:  [
          for (var i = 0; i < 6; i++) PostCard(content: _contentlist[i], userdata: _userlist[i],likes: _likes[i],),
        ],
      )
    );
  }
}


class PostCard extends StatelessWidget {
  final String content;
  final String userdata;
  final List likes;
  
  const PostCard({
    super.key, required this.content, required this.userdata, required this.likes,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child:   SizedBox(
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
                      child: Text(userdata, style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
              const Center(child: SizedBox()),
              Align(
                alignment: Alignment.topLeft,
                child: Text(content,style: const TextStyle(fontSize: 15)),
              ),
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.thumb_up_alt_rounded),
                  Text(likes[0]),
                  const Icon(Icons.thumb_down_alt_rounded),
                  Text(likes[1]), 
                  const Icon(Icons.comment),
                  Text(likes[2]),
                ],
              )
            ]
          ),
        ) ,
      ),
    );
  }
}