import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/user_authentication_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/avatar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentuser;
  final UserAuthenticationService authService = UserAuthenticationService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      loadUser();
    });
  }

  void loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('username') == null) {
      return;
    }

    User user =
        (await authService.getCurrentUser(prefs.getString('username')))!;
    await authService.getUserDetails(user);

    setState(() {
      currentuser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: TextConstants.titleText),
        drawer: const CustomDrawer(),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            DisplayAvatar(
                byteData: currentuser.profileImage,
                onPressed: () {},
                size: 50),
            Text(
              currentuser.name!,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Text(
              currentuser.username!,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            buildProfileSection(
                "About Me",
                Text(
                  currentuser.about ?? 'About Me',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontFamily: 'Roboto Mono',
                    color: Colors.white,
                  ),
                )),
            // buildProfileSection(
            //   "Liked Posts",
            //   currentuser.likedPosts.isEmpty
            //       ? const Text("No Liked Posts")
            //       : ListView(
            //           children: [
            //             for (var i = 0; i < currentuser.likedPosts.length; i++)
            //               PostCard(post: currentuser.likedPosts[i]),
            //           ],
            //         ),
            // ),
            // buildProfileSection("Games",
            //   currentuser!.likedGames.isEmpty 
            //     ? const Text("No Games")
            //     : ListView(
            //       children:  [
            //         for (var i = 0; i < currentuser!.likedGames.length; i++) 
            //           GameCard(game: currentuser!.likedGames[i]),
            //       ],
            //     ),
            // ),
          ],
        ));
  }
}

Widget buildUserInfoDisplay(String text, String title) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );

Widget buildProfileSection(String sectionName, Widget child) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Positioned(right: -25, top: 0, child: textAsButton(sectionName)),
        const SizedBox(height: 1),
        Container(
            padding: const EdgeInsets.all(10),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color(0xff010101),
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
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Align(alignment: Alignment.topLeft, child: child),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: buildEditIcon(
                          Colors.white, () {}, const Color(0xff5D281B)),
                    ),
                  ])
                ]))
      ],
    ));

Widget textAsButton(String text) => TextButton(
      onPressed: () {},
      child: Container(
        width: 150,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF4F6FC),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );

Widget buildEditIcon(Color color, VoidCallback onPressed,
        [Color? background]) =>
    CircleAvatar(
        // radius: 100,
        backgroundColor: background,
        child: IconButton(
          icon: Icon(
            Icons.edit,
            color: color,
            size: 15,
          ),
          onPressed: onPressed,
        ));
