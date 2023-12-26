import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/post_service.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/guest_control_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:filter_list/filter_list.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<Game> allGames = [];
  List<Game> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextConstants.titleText),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: getPostsByGame(selected),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data!;
              // Sort the posts by created date in descending order
              posts.sort((a, b) => b.createdDate.compareTo(a.createdDate));

              return ListView(
                children: [
                  for (var i = 0; i < posts.length; i++)
                    PostCard(post: posts[i]),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GuestControlWidget(
              widgetToShowLoggedInUser: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create_post').then((value) {
                if (value != null && value == "create") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Post created"),
                    ),
                  );
                  // refresh the current page
                  Navigator.pushReplacementNamed(context, '/');
                }
              });
            },
            child: const Icon(
              Icons.add,
              color: ColorConstants.buttonColor,
            ),
          )),
          FloatingActionButton(
            onPressed: openPostFilterDialog,
            child: const Icon(
              Icons.filter_alt,
              color: ColorConstants.buttonColor,
            ),
          ),
        ],
      ),
    );
  }

  void openPostFilterDialog() async {
    await FilterListDialog.display<Game>(context,
        listData: allGames,
        selectedListData: allGames,
        height: 480,
        headlineText: "Filter Posts by Game",
        choiceChipLabel: (item) => item!.title,
        validateSelectedItem: (list, val) {
          return list!.contains(val);
        },
        onItemSearch: (game, query) {
          return game.title.toLowerCase().contains(query.toLowerCase());
        },
        onApplyButtonClick: (list) {
          if (list != null) {
            setState(() {
              selected = List.from(list);
            });
          }
          // Navigator.pop(context);
        });
  }

  Future<List<Post>> getPostsByGame(List<Game> selected) async {
    if (allGames.isEmpty) {
      allGames = await GameService().getGames();
    }

    if (selected.isEmpty || selected.length == allGames.length) {
      return PostService().getPosts();
    }

    List<Post> posts = [];
    for (var i = 0; i < selected.length; i++) {
      List<Post> postsByGame =
          await PostService().getPostsByGame(selected[i].gameId);
      posts.addAll(postsByGame);
    }

    return posts;
  }
}
