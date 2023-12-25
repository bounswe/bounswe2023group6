import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/annotation_model.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/pages/game_page_create.dart';
import 'package:mobile/presentation/pages/post/report_widget.dart';
import 'package:mobile/presentation/widgets/annotatable_image_widget.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/presentation/widgets/guest_control_widget.dart';
import 'package:mobile/presentation/widgets/lfg_card_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:mobile/presentation/widgets/vertical_game_card_widget.dart';


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
          gameId: gameId,
        ),
        floatingActionButton: GuestControlWidget(
            widgetToShowLoggedInUser: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GamePageCreate(selectedGame: _GameWikiPageState.game),
              ),
            ).then((value) {
              if (value != null && value == "create") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Game created"),
                  ),
                );
                // refresh the current page
                Navigator.pushReplacementNamed(context, '/');
              }
            });
          },
          child: const Icon(
            Icons.edit,
            color: ColorConstants.buttonColor,
          ),
        )));
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
  final List<Game> similarGameList = GameService.getGameDataList();
  final GameService gameService = GameService();
  final PostService postService = PostService();
  final LFGService lfgService = LFGService();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // loadGameData(widget.gameId);
    // loadRelatedPosts();

    setState(() {
      tabController = TabController(length: 2, vsync: this);
    });
  }

  // late List<Post> relatedPosts;
  //static late Game game;
  //Future<void> loadGameData(int gameId) async {
  //  Game gameData = await gameService.getGame(gameId);
  //  setState(() {
  //    game = gameData;
  //  });
  //}

  // Future<void> loadRelatedPosts() async {
  //   List<Post> postList = await postService.getPosts();
  //   setState(() {
  //     relatedPosts =  postList;
  //   });
  // }

  static late Game game;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> controllerNames = ['Name', 'Description'];

  Future<Game> loadGame(int gameId) async {
    Game game = await gameService.getGame(gameId);
    List<Post> postList = await postService.getPostsByGame(gameId);
    if (game.similarGameIds.isEmpty) {
      game.similarGameList = await gameService.getRecommendedGames();
    } else {
      List<Game> allGames = await gameService.getGames();
      List<Game> similarGames = allGames
          .where((element) => game.similarGameIds.contains(element.gameId))
          .toList();
      game.similarGameList = similarGames;
    }
    List<LFG> allLfgs = await lfgService.getLFGs();
    List<LFG> relatedLFGs = allLfgs
        .where((element) => element.relatedGameId == game.gameId)
        .toList();

    game.relatedPosts = postList;
    game.relatedLFGs = relatedLFGs;

    return game;
  }

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadGame(widget.gameId),
        builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
          if (snapshot.hasData) {
            game = snapshot.data!;
            return ListView(
              children: [
                Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Text(game.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ReportWidgetForGame(
                                      gameid: game.gameId,
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.warning),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Release Year: ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          game.releaseYear!.toString() ?? "-",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // const Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Text("Released By:  ",
                                  //         style: TextStyle(
                                  //             fontSize: 15,
                                  //             fontWeight: FontWeight.w600))),
                                  // Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Text(game.developers ?? "-",
                                  //         style: TextStyle(
                                  //             fontSize: 12,
                                  //             fontWeight: FontWeight.w400))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Genre: ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(game.genres![0] ?? "-",
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
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(game.averageRating.toString(),
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
                                    allowHalfRating: false,
                                    itemSize: 30,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                      gameService.rateGame(
                                          game.gameId, rating.round());
                                    },
                                  ),
                                ],
                              )),
                              AnnotatableImageWidget(
                                  imageUrl: game.gamePicture,
                                  contentId: game.gameId,
                                  contentContext: AnnotationContext.game),
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 500,
                          child: MarkdownBody(
                            data: game.description,
                            shrinkWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    width: 500,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Additional Information",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        if (game.platforms != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Platforms: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: game.platforms![0],
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (game.mechanics != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Mechanics: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: game.mechanics!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (game.universe != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Universe: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: game.universe!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (game.playerNumber != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Player Number: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: game.playerNumber!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (game.playtime != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Playtime: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: game.playtime!,
                                  )
                                ],
                              )),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.center,
                              child: Text("Characters",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ))),
                          Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  _dialogBuilder(context);
                                },
                                child: Icon(Icons.add),
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            height: 75,
                            child: ListView(
                              // This next line does the trick.
                              scrollDirection: Axis.vertical,
                              children: [
                                if (game.characters != null)
                                  for (var i = 0;
                                      i < game.characters!.length;
                                      i++)
                                    Row(
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: game.characters![i].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            TextSpan(
                                              text: ": ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            TextSpan(
                                              text: game
                                                  .characters![i].description,
                                            )
                                          ],
                                        )),
                                      ],
                                    ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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
                                for (var i = 0;
                                    i < game.similarGameList.length;
                                    i++)
                                  VerticalGameCard(
                                      game: game.similarGameList[i]),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Column(
                                      // This next line does the trick.
                                      children: [
                                        for (var i = 0;
                                            i < game.relatedPosts.length;
                                            i++)
                                          PostCard(post: game.relatedPosts[i]),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: game.relatedLFGs.isNotEmpty
                                    ? Column(
                                        // This next line does the trick.
                                        children: [
                                          for (var i = 0;
                                              i < game.relatedLFGs.length;
                                              i++)
                                            LFGCard(lfg: game.relatedLFGs[i]),
                                        ],
                                      )
                                    : const Center(
                                          child: Text("Nothing to show",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ))),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),                          
                        ],
                      )),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    right: -40,
                    top: -40,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: nameController,
                            decoration:
                                InputDecoration(hintText: 'Character Name'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            minLines: 3,
                            maxLines: 5,
                            controller: descriptionController,
                            decoration: InputDecoration(
                                hintText: 'Character Description'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () {
                              gameService.createCharacter(
                                  game.gameId,
                                  nameController.text,
                                  descriptionController.text);
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}

// class VerticalGameCard extends StatelessWidget {
//   final Game game;

//   const VerticalGameCard({super.key, required this.game});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, "/game", arguments: game.id);
//       },
//       child: SizedBox(
//         width: 130,
//         child: Column(children: [
//           Container(
//             height: 160,
//             width: 120,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//               image: NetworkImage(game.imageLink),
//               fit: BoxFit.fill,
//             )),
//           ),
//           Text(
//             game.name,
//             maxLines: 3,
//           ),
//         ]),
//       ),
//     );
//   }
// }


