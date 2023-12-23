import 'package:flutter/material.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/pages/post/content_card_widget.dart';
import 'package:mobile/presentation/pages/post/post_page.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final LFGService lfgService = LFGService();
  final PostService commentService = PostService();
  late User currentUser;
  final TextEditingController _commentController = TextEditingController();

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
    List<Comment> commentList = await commentService.getComments(lfgId);

    commentList.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    await lfg.loadLfgSocialData();
    for (var comment in commentList) {
      await comment.loadContentSocialData();
    }
    lfg.commentList = commentList;

    return MainContentState(lfg);
  }

  // static late LFG lfg;

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
              Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        children: [
                          userInformationSection(context, lfg.ownerUsername,
                              lfg.ownerProfileImage),
                          Flexible(
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    lfg.title!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(lfg.content),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Game: ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Language: ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Platform: ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Mic/Cam: ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.people),
                          Container(
                            child: Column(children: [
                              Text("Players"),
                              Text("3/5"),
                            ]),
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 100,
                              height: 40,
                              //color: Colors.amberAccent,
                              child: Center(child: Text("JOIN")),
                            ),
                          )
                        ],
                      )
                    ]),
                  )),
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
        );
      },
    );
  }

  Widget leaveNewCommentSectionLfg(LFG lfg) {
    return Consumer<MainContentState>(
      builder: (context, lfgState, child) {
        return Card(
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
                        Comment comment = await lfgService.createComment(
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
}
