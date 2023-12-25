import 'package:flutter/material.dart';
import 'package:mobile/presentation/pages/forum_page.dart';
import 'package:mobile/presentation/pages/game_page.dart';
import 'package:mobile/presentation/pages/game_page_create.dart';
import 'package:mobile/presentation/pages/game_wiki_page.dart';
import 'package:mobile/presentation/pages/group_page.dart';
import 'package:mobile/presentation/pages/lfg_page_create.dart';
import 'package:mobile/presentation/pages/login_page.dart';
import 'package:mobile/presentation/pages/post/post_create_page.dart';
import 'package:mobile/presentation/pages/post/post_page.dart';
import 'package:mobile/presentation/pages/profile_page.dart';

class CustomNavigator extends StatefulWidget {
  CustomNavigator({super.key, required this.defaultPage});
  final GlobalKey<NavigatorState> defaultKey = GlobalObjectKey(UniqueKey());
  final Widget defaultPage;

  @override
  State<CustomNavigator> createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.defaultKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case "/post":
                  return PostPage();
                case "/create_post":
                  return const PostCreatePage();
                case "/game":
                  return const GameWiki();
                case "/profile":
                  return const ProfilePage();
                case "/create_game_page":
                  return const GamePageCreate();
                case "/create_lfg_page":
                  return const LFGPageCreate();
                case "/group":
                  return GroupPage();
                case "/login":
                  return LoginPage();
                default:
                  return widget.defaultPage;
              }
            });
      },
    );
  }
}
