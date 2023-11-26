import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/markdown_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';

class GameWiki extends StatefulWidget {
  const GameWiki({super.key});

  @override
  State<GameWiki> createState() => _GameWikiState();
}

class _GameWikiState extends State<GameWiki> {
  @override
  Widget build(BuildContext context) {
    final int gameId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: CustomAppBar(title: "Game Page"),
      body: GameWikiPage(
        gameId: gameId - 1,
      ),
    );
  }
}

class GameWikiPage extends StatefulWidget {
  GameWikiPage({super.key, required this.gameId});

  final int gameId;

  @override
  State<GameWikiPage> createState() => _GameWikiPageState();
}

class _GameWikiPageState extends State<GameWikiPage>
    with SingleTickerProviderStateMixin {
  final List<Game> itemList = GameService.getGameDataList();
  final GameService gameService = GameService();
  final PostService postService = PostService();
  late List<Post> relatedPosts;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    loadGameData(widget.gameId);
    loadRelatedPosts();
    setState(() {
      tabController = TabController(length: 2, vsync: this);
    });
  }

  late Game game;

  Future<void> loadGameData(int gameId) async {
    Game gameData = await gameService.getGame(gameId);
    setState(() {
      game = gameData;
    });
  }

  Future<void> loadRelatedPosts() async {
    List<Post> postList = await postService.getPosts();
    setState(() {
      relatedPosts = postList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 500,
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text(game.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                        const SizedBox(
                          height: 15,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Release Date: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Jan 25, 2018",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Released By:  ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Maddy Makes Games",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Genre: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Adventure, Indie, Platform",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Rating: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500))),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("4.5",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 30,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    )),
                    Container(
                      height: 200,
                      width: 150, // Size of image
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(game.imageLink),
                        fit: BoxFit.fill,
                      )),
                    ),
                  ],
                ),
              ]),
            )),
        SizedBox(
          height: 10,
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 500,
                child: MarkdownBody(
                  data: game.description,
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Text("Similar Games",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ))),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 195,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var i = 0; i < 6; i++)
                          VerticalGameCard(game: itemList[i]),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
              width: 500,
              //height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        text: 'Related Posts',
                      ),
                      Tab(
                        text: 'Related LFGs',
                      ),
                    ],
                    labelColor: Colors.black,
                  ),
                  Container(
                    child: AutoScaleTabBarView(
                        controller: tabController,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              // This next line does the trick.
                              children: [
                                for (var i = 0; i < relatedPosts.length; i++)
                                  PostCard(post: relatedPosts[i]),
                              ],
                            ),
                          ),
                          const Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Center(
                                  child: Text("Nothing to show",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ))),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          )
                        ]),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class VerticalGameCard extends StatelessWidget {
  final Game game;

  const VerticalGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/game", arguments: game.id);
      },
      child: SizedBox(
        width: 130,
        child: Column(children: [
          Container(
            height: 160,
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(game.imageLink),
              fit: BoxFit.fill,
            )),
          ),
          Text(
            game.name,
            maxLines: 3,
          ),
        ]),
      ),
    );
  }
}
