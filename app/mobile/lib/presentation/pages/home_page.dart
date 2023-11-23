import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/post_service.dart';

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
        ));
  }
}
