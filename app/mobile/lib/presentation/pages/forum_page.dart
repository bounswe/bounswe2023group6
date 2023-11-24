import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/post_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: TextConstants.titleText),
        drawer: const CustomDrawer(),
        body: FutureBuilder(
          future: PostService().getPosts(), 
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data!;
              return ListView(
                children: [
                  for (var i = 0; i < 6; i++) PostCard(post: posts[i]),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        ),
        floatingActionButton: isLoggedIn
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_post');
                },
                child: const Icon(Icons.add),
              )
            : FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Icon(Icons.login),
            )
    );
  }
}
