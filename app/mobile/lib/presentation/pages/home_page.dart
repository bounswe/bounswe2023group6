import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/data/services/post_service.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/lfg_card_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';
import 'package:mobile/presentation/widgets/vertical_game_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameService gameService = GameService();
  final PostService postService = PostService();
  final LFGService lfgService = LFGService();

  Future<List<Post>> loadPosts() async {
 
    List<Post> postList = await postService.getRecommendedPosts();

    return postList;
  }

  Future<List<Game>> loadGames() async {

    List<Game> gameList = await gameService.getRecommendedGames();

    return gameList;
  }

  Future<List<LFG>> loadLfgs() async {
    List<LFG> lfgList = await lfgService.getRecommendedLFGs();
    return lfgList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: TextConstants.titleText),
        drawer: const CustomDrawer(),
        body: FutureBuilder(
          future: Future.wait([loadPosts(),loadGames(), loadLfgs()]), 
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data![0];
              List<Game> games = snapshot.data![1];
              List<LFG> lfgs = snapshot.data![2];
              return ListView(
                children: [
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/search');
                      },
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Card(
                    margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                    //color: ColorConstants.color2,
                    child: Column(
                      children: [
                        Text("Recommended Games", style: TextStyle(fontSize: 18),),
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: 195,                    
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var i = 0; i < games.length; i++) VerticalGameCard(game: games[i]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),  
                  SizedBox(height: 15,),
                  Card(
                    margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text("Recommended Posts", style: TextStyle(fontSize: 18),),
                        for (var i = 0; i < posts.length; i++) PostCard(post: posts[i]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Card(
                    margin:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const Text("Recommended LFGs", style: TextStyle(fontSize: 18),),
                        for (var i = 0; i < lfgs.length; i++) LFGCard(lfg: lfgs[i]),
                      ],
                    ),
                  ),

                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        ));
  }
}
