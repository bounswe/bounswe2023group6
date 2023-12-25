import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/constants/object_keys.dart';
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

  User currentUser = CacheManager().getUser();
  late User profileUser;
  bool pageInitialized = false;
  bool refreshPage = false;
  bool isProfileOfCurrentUser = false;
  bool isEditingAboutMe = false;
  bool isFollowing = false;

  Future<User> loadUser(String profileUsername) async {
    if (pageInitialized && !refreshPage) {
      return profileUser;
    }

    if (refreshPage) {
      profileUser = await userService.getUser(profileUsername);
      if (isProfileOfCurrentUser) {
        // Update the user in the cache
        await CacheManager().saveUser(profileUser);
      }
    } else {
      if (currentUser.username == profileUsername) {
        profileUser = currentUser;
        isProfileOfCurrentUser = true;
      } else {
        profileUser = (await userService.getUser(profileUsername));
        if (!profileUser.isProfileVisible) {
          throw Exception("This profile is not visible");
        }
      }
    }
    await userService.getUserDetails(profileUser);
    List<User> followings = await userService.getFollowings();
    isFollowing = false;
    for (User following in followings) {
      if (following.username == profileUser.username) {
        isFollowing = true;
        break;
      }
    }

    pageInitialized = true;
    refreshPage = false;
    return profileUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadUser(ModalRoute.of(context)!.settings.arguments as String),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("This profile is not visible"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"))
                  ],
                );
              } else {
                return buildProfilePage(profileUser);
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void updateProfileAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await userService.updateUser(profileUser, imageFilePath: pickedFile.path);
      setState(() {
        refreshPage = true;
      });
    }
  }

  Widget buildProfilePage(User user) => Scaffold(
        appBar: CustomAppBar(title: TextConstants.titleText),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // put a sized box to center the avatar
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DisplayAvatar(
                            imageLink: user.profilePicture,
                            onPressed: isProfileOfCurrentUser
                                ? updateProfileAvatar
                                : null,
                            size: 50),
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
                        if (user.title != null &&
                            user.title != "" &&
                            user.company != null &&
                            user.company != "")
                          Text(
                            "${user.title} at ${user.company}",
                            style: const TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        isProfileOfCurrentUser
                            ? buildChangeVisibilityButton()
                            : Container(),
                        const SizedBox(height: 10),
                        isProfileOfCurrentUser
                            ? buildChangeProfileInformationButton()
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              buildTagSection(),
              const SizedBox(height: 10),
              buildFollowSection(),
              const SizedBox(height: 10),
              buildProfileSection(
                "About Me",
                isEditingAboutMe
                    ? TextField(
                        key: GlobalStaticKeys.profilePageEditorKey,
                        controller: aboutMeController,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
                () async {
                  isEditingAboutMe = !isEditingAboutMe;
                  if (!isEditingAboutMe) {
                    profileUser.about = aboutMeController.text;
                    await userService.updateUser(profileUser);
                    setState(() {
                      refreshPage = true;
                    });
                  } else {
                    setState(() {
                      aboutMeController.text = profileUser.about ?? '';
                    });
                  }
                },
              ),
              buildProfileSection(
                "Created Posts",
                user.createdPosts.isEmpty
                    ? const Text("No Created Posts",
                        style: TextStyle(color: Colors.white))
                    : ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          for (var i = 0; i < user.createdPosts.length; i++)
                            PostCard(post: user.createdPosts[i]),
                        ],
                      ),
              ),
              buildProfileSection(
                "Liked Posts",
                user.likedPosts.isEmpty
                    ? const Text("No Liked Posts",
                        style: TextStyle(color: Colors.white))
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
                    ? const Text("No Liked Games",
                        style: TextStyle(color: Colors.white))
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
                                padding:
                                    const EdgeInsets.fromLTRB(3, 15, 3, 15),
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

  Widget buildFollowSection() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!isProfileOfCurrentUser)
            TextButton(
              onPressed: () async {
                if (!isFollowing) {
                  await userService.followUser(profileUser);
                } else {
                  await userService.unfollowUser(profileUser);
                }
                setState(() {
                  refreshPage = true;
                });
              },
              child: Container(
                width: 150,
                height: 30,
                padding: const EdgeInsets.only(
                    left: 15, right: 1, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.buttonColor,
                ),
                child: !isFollowing
                    ? const Text(
                        "Follow",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        "Unfollow",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
          const SizedBox(height: 10),
          // Show followers and following count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 30,
                padding: const EdgeInsets.only(
                    left: 15, right: 1, top: 5, bottom: 5),
                child: Text(
                  "Followers: ${profileUser.followers}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 30,
                padding: const EdgeInsets.only(
                    left: 15, right: 1, top: 5, bottom: 5),
                child: Text(
                  "Following: ${profileUser.following}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget buildChangeVisibilityButton() => TextButton(
        onPressed: () async {
          // Add logic to change visibility
          profileUser.isProfileVisible = !profileUser.isProfileVisible;
          await userService.updateUser(profileUser);
          setState(() {
            refreshPage = true;
          });
        },
        child: Container(
          width: 150,
          height: 50,
          padding: const EdgeInsets.only(left: 15, right: 1, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // make color dependent on visibility
            color: profileUser.isProfileVisible
                ? ColorConstants.color1
                : ColorConstants.color2,
          ),
          child: Text(
            profileUser.isProfileVisible
                ? "Visibility: Public"
                : "Visibility: Private",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      );

  Widget buildChangeProfileInformationButton() => TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Change Profile Information"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller:
                          TextEditingController(text: profileUser.title),
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                      onChanged: (String value) {
                        profileUser.title = value;
                      },
                    ),
                    TextField(
                      controller:
                          TextEditingController(text: profileUser.company),
                      decoration: const InputDecoration(
                        labelText: "Company",
                      ),
                      onChanged: (String value) {
                        profileUser.company = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await userService.updateUser(profileUser);
                      setState(() {
                        refreshPage = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: 150,
          height: 45,
          padding: const EdgeInsets.only(left: 15, right: 1, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blueAccent,
          ),
          child: const Text(
            "Change Profile Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      );

  Widget buildTagSection() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (profileUser.tags.isNotEmpty)
            Column(children: [
              const Text(
                "Tags",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (String tag in profileUser.tags)
                    Container(
                      width: 150,
                      height: 30,
                      padding: const EdgeInsets.only(
                          left: 15, right: 1, top: 5, bottom: 5),
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.color1,
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ]),
          const SizedBox(height: 10),
          if (isProfileOfCurrentUser) buildAddNewTagSection(),
        ],
      );

  Widget buildAddNewTagSection() {
    String newTag = "";
    return TextButton(
      onPressed: () {
        // Add logic to add tags
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Add Tags"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Tag",
                    ),
                    onChanged: (String value) {
                      newTag = value;
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    profileUser.tags.add(newTag);
                    await userService.updateUser(profileUser);
                    setState(() {
                      refreshPage = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 150,
        height: 30,
        padding: const EdgeInsets.only(left: 15, right: 1, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorConstants.buttonColor,
        ),
        child: const Text(
          "Add Tags",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

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

  Widget buildEditIcon(Color color, VoidCallback onPressed,
      [Color? background]) {
    return CircleAvatar(
      backgroundColor: background,
      child: IconButton(
        icon: Icon(
          isEditingAboutMe ? Icons.check : Icons.edit,
          color: color,
          size: 15,
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
