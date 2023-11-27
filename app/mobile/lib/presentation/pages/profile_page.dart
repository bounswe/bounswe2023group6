import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/user_service.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:mobile/utils/shared_manager.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/avatar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();
  final TextEditingController aboutMeController = TextEditingController();

  late User currentUser;
  late User profileUser;
  bool pageInitialized = false;
  bool isProfileOfCurrentUser = false;
  bool isEditingAboutMe = false;

  Future<void> loadUser(String profileUsername) async {
    if (pageInitialized) {
      return;
    }
    final SharedManager manager = SharedManager();
    await manager.init();
    User currentUserLocal = CacheManager(manager).getUser();

    User profileUserLocal;
    if (currentUserLocal.username == profileUsername) {
      profileUserLocal = currentUserLocal;
      isProfileOfCurrentUser = true;
    } else {
      profileUserLocal = (await userService.getUser(profileUsername));
    }
    await userService.getUserDetails(profileUserLocal);

    setState(() {
      currentUser = currentUserLocal;
      profileUser = profileUserLocal;
    });

    pageInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadUser(ModalRoute.of(context)!.settings.arguments as String),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return buildProfilePage(currentUser);
              }
          }
        });
  }

  Widget buildProfilePage(User user) => Scaffold(
      appBar: CustomAppBar(title: TextConstants.titleText),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayAvatar(
                byteData: user.profileImage, 
                onPressed: isProfileOfCurrentUser 
                  ? () {}
                  : null, 
                size: 50
              ),
            Text(
              user.name ?? 'Name',
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Text(
              "@${user.username}",
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            buildProfileSection(
              "About Me",
              isEditingAboutMe
                  ? TextField(
                      controller: aboutMeController,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: null,
                    )
                  : Text(
                      user.about ?? 'About Me',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontFamily: 'Roboto Mono',
                        color: Colors.white,
                      ),
                    ),
              () {},
            ),
            buildProfileSection(
              "Liked Posts",
              user.likedPosts.isEmpty
                  ? const Text("No Liked Posts")
                  : ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        for (var i = 0; i < user.likedPosts.length; i++)
                          PostCard(post: user.likedPosts[i]),
                      ],
                    ),
            ),
            buildProfileSection(
              "Games",
              user.likedGames.isEmpty
                  ? const Text("No Games")
                  : ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        for (var i = 0; i < user.likedGames.length; i++)
                          GameCard(game: user.likedGames[i]),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );

  Widget buildProfileSection(String sectionName, Widget child,
          [VoidCallback? editCallback]) =>
      Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorConstants.color3,
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, spreadRadius: 1),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(3, 15, 3, 15),
                                child: Align(
                                    alignment: Alignment.topLeft, child: child),
                              ),
                              editCallback != null && isProfileOfCurrentUser
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: buildEditIcon(Colors.white,
                                          editCallback, ColorConstants.color1),
                                    )
                                  : Container(),
                            ])
                          ]))
                ],
              ),
              Positioned(left: 0, top: -10, child: textAsButton(sectionName)),
            ],
          ));

  Widget textAsButton(String text) => TextButton(
        onPressed: () {},
        child: Container(
          width: 150,
          height: 30,
          padding: const EdgeInsets.only(left: 15, right: 1, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorConstants.color2,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      );

  Widget buildEditIcon(Color color, VoidCallback onPressed, [Color? background]) {
    return CircleAvatar(
      backgroundColor: background,
      child: IconButton(
        icon: Icon(
          isEditingAboutMe ? Icons.check : Icons.edit,
          color: color,
          size: 15,
        ),
        onPressed: () {
          setState(() {
            isEditingAboutMe = !isEditingAboutMe;
            if (!isEditingAboutMe) {
              profileUser.about = aboutMeController.text;
              // Add logic to save the updated about text in your database or backend if necessary
            } else {
              aboutMeController.text = profileUser.about ?? '';
            }
          });
          onPressed();
        },
      ),
    );
  }
}
