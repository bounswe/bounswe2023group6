import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/comment_service.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/pages/lfg_page_create.dart';
import 'package:mobile/presentation/pages/login_page.dart';
import 'package:mobile/presentation/pages/post/content_card_widget.dart';
import 'package:mobile/presentation/pages/post/post_page.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final LFGService lfgService = LFGService();
  final CommentService commentService = CommentService();
  final GameService gameService = GameService();

  late User currentUser;
  final TextEditingController _commentController = TextEditingController();
  static late LFG selectedLFG;
  static late Game selectedGame;
  @override
  void initState() {
    super.initState();
    initializeUser();
  }

  Future<void> initializeUser() async {
    currentUser = CacheManager().getUser();
  }

  Future<MainContentState> loadlfg(int lfgId) async {
    LFG lfg = await lfgService.getLFG(lfgId);
    selectedLFG = lfg;
    List<Comment> commentList = await commentService.getCommentsForLfg(lfgId);
    selectedGame = await gameService.getGame(lfg.relatedGameId!);

    commentList.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    await lfg.loadLfgSocialData();
    for (var comment in commentList) {
      await comment.loadContentSocialData();
    }
    lfg.commentList = commentList;

    return MainContentState(lfg);
  }

  @override
  Widget build(BuildContext context) {
    final int lfgId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
        future: loadlfg(lfgId),
        builder:
            (BuildContext context, AsyncSnapshot<MainContentState> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ChangeNotifierProvider(
                  create: (context) => snapshot.data!,
                  child: buildGroupPage(),
                );
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildGroupPage() {
    return Consumer<MainContentState>(
      builder: (context, lfgState, child) {
        LFG lfg = lfgState.mainContent as LFG;
        return Scaffold(
          appBar: CustomAppBar(title: "LFG Page"),
          body: SingleChildScrollView(
              child: Column(
            children: [
              buildLFGCard(lfg),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              leaveNewCommentSectionLfg(lfg),
              for (var comment in lfg.commentList)
                ContentCardWidget(
                    content: comment,
                    parentContent: (comment.parentContentId != null &&
                            comment.parentContentId != 0)
                        ? lfg.commentList.firstWhere(
                            (element) => element.id == comment.parentContentId)
                        : null),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LFGPageCreate(
                        selectedLFG: _GroupPageState.selectedLFG)),
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
          ),
        );
      },
    );
  }

  Widget buildLFGCard(LFG lfg) {

    bool isUserMember = lfg.members!.any((element) => element.userId == currentUser.userId,);
    
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                userInformationSection(
                    context, lfg.ownerUsername, lfg.ownerProfileImage),
                Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lfg.title!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            lfgMoreOptionsSection(lfg),
                          ],
                        ),
                        Text(lfg.content),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Game: ",
                                    style:
                                        TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: selectedGame.title,
                                  )
                                ],
                              ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Language: ",
                                    style:
                                        TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: lfg.requiredLanguage,
                                  )
                                ],
                              ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Platform: ",
                                    style:
                                        TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: lfg.requiredPlatform,
                                  )
                                ],
                              ))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Mic/Cam: ",
                                    style:
                                        TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: lfg.micCamRequirement.toString(),
                                  )
                                ],
                              ))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _dialogBuilder(context);
                              },
                              child: Icon(Icons.people)
                            ),
                            Container(
                              child: Column(children: [
                                Text("Players",style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: lfg.members!.length.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: "/",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),                                  
                                  TextSpan(
                                    text: lfg.memberCapacity.toString(),
                                    style:
                                      TextStyle(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ))
                              ]),
                            ),
                            if(!isUserMember)
                            InkWell(
                              onTap: () async{
                                await lfgService.joinLfg(lfg.id);
                                setState(() {
                                  
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                width: 80,
                                height: 40,
                                //color: Colors.amberAccent,
                                child: const Center(child: Text("Join")),
                              ),
                            ),
                            if(isUserMember)
                            InkWell(
                              onTap: () async{
                                await lfgService.leaveLfg(lfg.id);
                                setState(() {
                                  
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                width: 80,
                                height: 40,
                                //color: Colors.amberAccent,
                                child: const Center(child: Text("Leave")),
                              ),
                            )                            
                          ],
                        ),
                        lfgSocialSection(lfg),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]),
        ));
  }

  Widget lfgMoreOptionsSection(LFG lfg) {
    bool isContentOfCurrentUser = (currentUser.username == lfg.ownerUsername);
    return PopupMenuButton<ContentMoreOptions>(
      icon: const Icon(Icons.more_vert),
      onSelected: (ContentMoreOptions result) {
        switch (result) {
          case ContentMoreOptions.edit:
            // TODO: go to update page
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return updateWidget(context, content: lfg);
            //   },
            // ).then((value) => {setState(() {})});
            break;
          case ContentMoreOptions.delete:
            // lfgService.deleteLFG(lfg.id);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Delete"),
                  content: const Text("Your post has been deleted."),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // connectedPostState.deleteContent(lfg);
                      },
                    ),
                  ],
                );
              },
            );
            break;
          case ContentMoreOptions.report:
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return ReportWidget(content: lfg);
            //   },
            // );
            break;
          case ContentMoreOptions.goToGamePage:
            Navigator.pushNamed(context, '/game', arguments: lfg.relatedGameId);
            break;
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ContentMoreOptions>>[
        if (isContentOfCurrentUser)
          const PopupMenuItem<ContentMoreOptions>(
            value: ContentMoreOptions.edit,
            child: Text('Edit'),
          ),
        if (isContentOfCurrentUser)
          const PopupMenuItem<ContentMoreOptions>(
            value: ContentMoreOptions.delete,
            child: Text('Delete'),
          ),
        if (!isContentOfCurrentUser)
          const PopupMenuItem<ContentMoreOptions>(
            value: ContentMoreOptions.report,
            child: Text('Report'),
          ),
        if (lfg.relatedGameId != null && lfg.relatedGameId != 0)
          const PopupMenuItem<ContentMoreOptions>(
            value: ContentMoreOptions.goToGamePage,
            child: Text('Go to game page'),
          ),
      ],
    );
  }

  Widget lfgSocialSection(LFG lfg) {
    //lfg.tags = ['tag1', 'tag2', 'tag3', 'tag4', 'tag5'];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // show tags
                if (lfg.tags != null)
                  for (String tag
                      in lfg.tags!.sublist(0, min(4, lfg.tags!.length)))
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          backgroundColor:
                              Theme.of(context).primaryIconTheme.color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(tag, style: const TextStyle(fontSize: 12)),
                      ),
                    ),
              ],
            ),
          ],
        ),
        const Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              timeago.format(lfg.createdDate),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget leaveNewCommentSectionLfg(LFG lfg) {
    return Consumer<MainContentState>(
      builder: (context, lfgState, child) {
        return Card(
          key: lfgState.commentDataKey,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userInformationSection(context, currentUser.username,
                      currentUser.profilePicture),
                  lfgState.currentCommentParentId != 0
                      ? Flexible(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            commentAsAReplySection(lfg.commentList.firstWhere(
                                (element) =>
                                    element.id ==
                                    lfgState.currentCommentParentId)),
                            newCommentSection(lfg),
                          ],
                        ))
                      : newCommentSection(lfg),
                ],
              )),
        );
      },
    );
  }

  Widget newCommentSection(LFG lfg) {
    return Consumer<MainContentState>(
      builder: (context, lfgState, child) {
        return Flexible(
          fit: FlexFit.loose,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Leave a comment',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      if (_commentController.text.isNotEmpty) {
                        int? parentId = lfgState.currentCommentParentId != 0
                            ? lfgState.currentCommentParentId
                            : null;
                        Comment comment = await commentService.createCommentForLfg(
                            lfg.id, _commentController.text, parentId);
                        lfgState.addComment(comment);
                        _commentController.clear();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your comment',
                  ),
                  onChanged: (text) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget commentAsAReplySection(Comment comment) {
    return Flexible(
        fit: FlexFit.loose,
        child: Column(children: [
          Row(
            children: [
              const Icon(Icons.reply),
              const SizedBox(
                width: 10,
              ),
              Text("Reply to ${comment.ownerUsername}"),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ContentCardWidget(content: comment, isReply: true),
        ]));
  }

  Future<void> _dialogBuilder(BuildContext context) {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Member List'),
          content: Container(
            height: 300.0, // Change as per your requirement
            width: 300.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: selectedLFG.members!.length ,
              itemBuilder: (BuildContext context, int index) {
                return userInformationSection(context, selectedLFG.members![index].username, selectedLFG.members![index].profilePicture);
              },
            ),
          ),
        );
      }
    );
  }

}
