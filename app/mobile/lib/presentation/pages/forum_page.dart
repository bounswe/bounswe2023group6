import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/post_service.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:mobile/utils/shared_manager.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    try {
      isLoggedIn = true;
      CacheManager().getUser();
    } catch (e) {
      isLoggedIn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: TextConstants.titleText),
        drawer: const CustomDrawer(),
        body: FutureBuilder(
            future: PostService().getPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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
        floatingActionButton: isLoggedIn
            ? FloatingActionButton(
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
              )
            : FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Icon(
                  Icons.login,
                  color: ColorConstants.buttonColor,
                ),
              ));
  }
}
