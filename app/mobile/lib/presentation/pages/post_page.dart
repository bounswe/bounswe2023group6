import 'package:flutter/material.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/post_service.dart';

enum ContentMoreOptions {
  edit,
  delete,
  report,
  reply,
}

class PostPage extends StatefulWidget {
  // Post post;
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostService postService = PostService();

  late Post post;
  bool initializedBefore = false;
  final TextEditingController _commentController = TextEditingController();
  // final User currentUser;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<bool> loadPostData() async {
    if (initializedBefore) {
      return true;
    }

    setState(() {
      post = ModalRoute.of(context)!.settings.arguments as Post;
    });
    List<Comment> commentList = await postService.getComments(post.id);
    setState(() {
      post.commentList = commentList;
    });

    initializedBefore = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadPostData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return buildPage();
          }
        });
  }

  Widget buildPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            contentCard(post),
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
            leaveNewCommentSection(post),
            for (var comment in post.commentList) contentCard(comment),
          ],
        ),
      ),
    );
  }

  Widget contentCard(Content content) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          userInformationSection(content),
          contentSection(content),
        ]),
      ),
    );
  }

  Widget contentSection(Content content) {
    return Flexible(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              content.type == ContentType.post
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Text(content.title!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  : const SizedBox.shrink(),
              contentMoreOptionsSection(content),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(content.content, style: const TextStyle(fontSize: 16)),
          ),
          // Text(post.timeAgo, style: const TextStyle(fontSize: 12,color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1),
          const SizedBox(
            height: 5,
          ),
          contentSocialSection(content),
        ],
      ),
    );
  }

  Widget contentMoreOptionsSection(Content content) {
    return PopupMenuButton<ContentMoreOptions>(
      icon: const Icon(Icons.more_vert),
      onSelected: (ContentMoreOptions result) {
        switch (result) {
          case ContentMoreOptions.edit:
            // TODO: go to edit page
            content.type == ContentType.post
                ? postService.updatePost(content)
                : postService.updateComment(content);
            print('edit');
            break;
          case ContentMoreOptions.delete:
            content.type == ContentType.post
                ? postService.deletePost(content.id)
                : postService.deleteComment(content.id);
            print('delete');
            break;
          case ContentMoreOptions.report:
            // TODO: go to report page
            content.type == ContentType.post
                ? postService.reportPost(content.id, "report")
                : postService.reportComment(content.id, "report");
            print('report');
            break;
          case ContentMoreOptions.reply:
            // TODO: implement reply
            print('reply');
            break;
        }
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ContentMoreOptions>>[
        const PopupMenuItem<ContentMoreOptions>(
          value: ContentMoreOptions.edit,
          child: Text('Edit'),
        ),
        const PopupMenuItem<ContentMoreOptions>(
          value: ContentMoreOptions.delete,
          child: Text('Delete'),
        ),
        const PopupMenuItem<ContentMoreOptions>(
          value: ContentMoreOptions.report,
          child: Text('Report'),
        ),
        const PopupMenuItem<ContentMoreOptions>(
          value: ContentMoreOptions.reply,
          child: Text('Reply'),
        ),
      ],
    );
  }

  Widget contentSocialSection(Content content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.thumb_up_alt_rounded),
              onPressed: () {
                if (content.type == ContentType.post) {
                  postService.upvotePost(content.id);
                  setState(() {
                    post.likes++;
                  });
                } else {
                  postService.upvoteComment(content.id);
                  setState(() {
                    post.commentList
                        .where((comment) => comment.id == content.id)
                        .first
                        .likes++;
                  });
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(content.likes.toString()),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.thumb_down_alt_rounded),
              onPressed: () {
                if (content.type == ContentType.post) {
                  postService.upvotePost(content.id);
                  setState(() {
                    post.dislikes++;
                  });
                } else {
                  postService.upvoteComment(content.id);
                  setState(() {
                    post.commentList
                        .where((comment) => comment.id == content.id)
                        .first
                        .dislikes++;
                  });
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(content.dislikes.toString()),
          ],
        )
      ],
    );
  }

  Widget leaveNewCommentSection(Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          userInformationSection(post),
          newCommentSection(post),
        ]),
      ),
    );
  }

  Widget newCommentSection(Post post) {
    return Flexible(
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
                onPressed: () {
                  Comment comment = Comment(
                    createdDate: DateTime.now(),
                    id: 0,
                    content: _commentController.text,
                    userId: post.userId,
                    username: post.username,
                  );
                  postService.createComment(post.id, comment);
                  setState(() {
                    post.commentList.add(comment);
                    _commentController.clear();
                  });
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
  }
}
