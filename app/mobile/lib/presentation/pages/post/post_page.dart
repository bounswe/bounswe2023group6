import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/pages/post/content_card_widget.dart';
import 'package:mobile/utils/shared_manager.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:provider/provider.dart';

class PostState extends ChangeNotifier {
  Post post;
  int currentCommentParentId = 0;
  final commentDataKey = GlobalKey<FormState>();
  late User currentUser;
  bool postDeleted = false;

  PostState(this.post) {
    initState();
  }

  void initState() async {
    final SharedManager manager = SharedManager();
    await manager.init();
    currentUser = CacheManager(manager).getUser();
    super.notifyListeners();
  }

  void updateCommentParentId(int id) {
    currentCommentParentId = id;
    // Navigate to the leave a comment section
    Scrollable.ensureVisible(commentDataKey.currentContext!);

    notifyListeners();
  }

  void addComment(Comment comment) {
    post.commentList.add(comment);
    // Sort the comments by created date
    post.commentList.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    currentCommentParentId = 0;

    notifyListeners();
  }

  void deleteContent(Content content) {
    if (content.type == ContentType.post) {
      postDeleted = true;
    } else {
      post.commentList.remove(content);
      post.commentList.forEach((element) {
        if (element.parentContentId == content.id) {
          deleteContent(element);
        }
      });
    }
    notifyListeners();
  }
}

class PostPage extends StatelessWidget {
  final PostService postService = PostService();

  final TextEditingController _commentController = TextEditingController();
  PostPage({Key? key}) : super(key: key);

  Future<PostState> loadPostData(int postId) async {
    Post post = await postService.getPost(postId);
    List<Comment> commentList = await postService.getComments(post.id);

    // Sort the comments by created date
    commentList.sort((a, b) => b.createdDate.compareTo(a.createdDate));

    await post.loadContentSocialData();
    for (var comment in commentList) {
      await comment.loadContentSocialData();
    }
    post.commentList = commentList;

    return PostState(post);
  }

  @override
  Widget build(BuildContext context) {
    final int postId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
        future: loadPostData(postId),
        builder: (BuildContext context, AsyncSnapshot<PostState> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ChangeNotifierProvider(
                  create: (context) => snapshot.data!,
                  child: buildPage(),
                );
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildPage() {
    return Consumer<PostState>(
      builder: (context, postState, child) {
        if (postState.postDeleted) {
          Future.microtask(() => Navigator.of(context).pop("delete"));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(postState.post.title!),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ContentCardWidget(content: postState.post, isPost: true),
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
                leaveNewCommentSection(postState.post),
                for (var comment in postState.post.commentList)
                  ContentCardWidget(
                      content: comment,
                      parentContent: comment.parentContentId != null &&
                              comment.parentContentId != 0
                          ? postState.post.commentList.firstWhere((element) =>
                              element.id == comment.parentContentId)
                          : null),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget leaveNewCommentSection(Post post) {
    return Consumer<PostState>(
      builder: (context, postState, child) {
        return Card(
          key: postState.commentDataKey,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userInformationSection(
                      context,
                      postState.currentUser.username,
                      postState.currentUser.profilePicture),
                  postState.currentCommentParentId != 0
                      ? Flexible(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            contentAsAReplySection(postState.post.commentList
                                .firstWhere((element) =>
                                    element.id ==
                                    postState.currentCommentParentId)),
                            newCommentSection(postState.post),
                          ],
                        ))
                      : newCommentSection(postState.post),
                ],
              )),
        );
      },
    );
  }

  Widget newCommentSection(Post post) {
    return Consumer<PostState>(builder: (context, postState, child) {
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    int? parentId = postState.currentCommentParentId != 0
                        ? postState.currentCommentParentId
                        : null;
                    Comment comment = await postService.createComment(
                        post.id, _commentController.text, parentId);
                    postState.addComment(comment);
                    _commentController.clear();
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
    });
  }

  Widget contentAsAReplySection(Content content) {
    return Flexible(
        fit: FlexFit.loose,
        child: Column(children: [
          Row(
            children: [
              const Icon(Icons.reply),
              const SizedBox(
                width: 10,
              ),
              Text("Reply to ${content.ownerUsername}"),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ContentCardWidget(content: content, isReply: true),
        ]));
  }
}
