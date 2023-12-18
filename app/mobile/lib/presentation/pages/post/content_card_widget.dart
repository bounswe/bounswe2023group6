import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/pages/post/post_page.dart';
import 'package:mobile/presentation/pages/post/report_widget.dart';
import 'package:mobile/presentation/pages/post/update_widget.dart';
import 'package:mobile/presentation/widgets/annotatable_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

enum ContentMoreOptions {
  edit,
  delete,
  report,
  reply,
  goToGamePage,
}

class ContentCardWidget extends StatefulWidget {
  final Content content;
  final bool isPost;
  final bool isReply;
  final Content? parentContent;

  const ContentCardWidget({
    Key? key,
    required this.content,
    this.isPost = false,
    this.isReply = false,
    this.parentContent,
  }) : super(key: key);

  @override
  State<ContentCardWidget> createState() => _ContentCardWidgetState();
}

class _ContentCardWidgetState extends State<ContentCardWidget> {
  PostService postService = PostService();
  late PostState connectedPostState;

  @override
  Widget build(BuildContext context) {
    Content content = widget.content;
    bool isPost = widget.isPost;
    bool isReply = widget.isReply;
    Content? parentContent = widget.parentContent;
    connectedPostState = context.watch<PostState>();
    bool isContentOfOriginalPoster = !isPost && content.ownerUserId ==
        connectedPostState.post.ownerUserId;

    return Card(
      key: !isPost && !isReply ? content.globalKey : null,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          userInformationSection(
              context, content.ownerUsername, content.ownerProfileImage,
              isContentOfOriginalPoster: isContentOfOriginalPoster),
          contentSection(content,
              parentContent: parentContent, isReply: isReply),
        ]),
      ),
    );
  }

  Widget contentSection(Content content,
      {Content? parentContent, bool isReply = false}) {
    return Flexible(
      child: Column(
        children: [
          if (parentContent != null)
            InkWell(
              onTap: () {
                // TODO: Change render objects border color for parent comment
                GlobalObjectKey parentContentGlobalKey = connectedPostState.post.commentList.where(
                  (element) => element.id == parentContent.id).first.globalKey;
                Scrollable.ensureVisible(
                    parentContentGlobalKey.currentContext!,
                    curve: Curves.easeInOut);
              },
              child: Align(
                  alignment: Alignment.topLeft,
                  child: ContentCardWidget(
                    content: parentContent,
                    isReply: true,
                  )),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              content.type == ContentType.post
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(content.title!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // show post category
                        MaterialButton(
                          onPressed: () {},
                          child: Text((content as Post).category.toString().split('.').last.toUpperCase(),
                              style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              !isReply
                  ? contentMoreOptionsSection(content)
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: AnnotatableTextWidget(text: content.content, contentId: content.id),
          ),
          const SizedBox(
            height: 5,
          ),
          !isReply ? contentSocialSection(content) : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget contentMoreOptionsSection(Content content) {
    bool isContentOfCurrentUser =
        (connectedPostState.currentUser.username == content.ownerUsername);
    return PopupMenuButton<ContentMoreOptions>(
      icon: const Icon(Icons.more_vert),
      onSelected: (ContentMoreOptions result) {
        switch (result) {
          case ContentMoreOptions.edit:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return updateWidget(context, content: content);
              },
            ).then((value) => {setState(() {})});
            break;
          case ContentMoreOptions.delete:
            content.type == ContentType.post
                ? postService.deletePost(content.id)
                : postService.deleteComment(content.id);
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
                        connectedPostState.deleteContent(content);
                      },
                    ),
                  ],
                );
              },
            );
            break;
          case ContentMoreOptions.report:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ReportWidget(content: content);
              },
            );
            break;
          case ContentMoreOptions.reply:
            connectedPostState.updateCommentParentId(content.id);
            break;
          case ContentMoreOptions.goToGamePage:
            print("go to game page ${content.relatedGameId}");
            // Navigator.pushNamed(context, '/game', arguments: content.relatedGameId);
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
        if (!widget.isPost) 
          const PopupMenuItem<ContentMoreOptions>(
            value: ContentMoreOptions.reply,
            child: Text('Reply'),
          ),
        if (widget.isPost && content.relatedGameId != 0)
          const PopupMenuItem<ContentMoreOptions>(
            value: ContentMoreOptions.goToGamePage,
            child: Text('Go to game page'),
          ),
      ],
    );
  }

  Widget contentSocialSection(Content content) {
    bool isLikedByCurrentUser = content.likeIds.contains(connectedPostState.currentUser.userId);
    bool isDislikedByCurrentUser = content.dislikeIds.contains(connectedPostState.currentUser.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // show tags
                if (content.tags != null)
                  for (String tag in content.tags!.sublist(0, min(4, content.tags!.length)))
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          backgroundColor: Theme.of(context).primaryIconTheme.color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(tag, style: const TextStyle(fontSize: 12)),
                      ),
                    ),
              ],
            ),
            Row(
              children: [
                // comment button
                if (content.type == ContentType.post)
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(content.comments.toString()),
                // upvote button
                IconButton(
                  icon: Icon(
                    isLikedByCurrentUser
                        ? Icons.thumb_up_alt_rounded
                        : Icons.thumb_up_alt_outlined,
                    color: isLikedByCurrentUser ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    if (content.type == ContentType.post) {
                      postService.upvotePost(content.id);
                    } else {
                      postService.upvoteComment(content.id);
                    }
                    if (isLikedByCurrentUser) {
                      setState(() {
                        widget.content.likes--;
                        widget.content.likeIds.remove(connectedPostState.currentUser.userId);
                      });
                    } else {
                      setState(() {
                        widget.content.likes++;
                        widget.content.likeIds.add(connectedPostState.currentUser.userId);
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(content.likes.toString()),

                // downvote button
                IconButton(
                  icon: Icon(
                    isDislikedByCurrentUser
                        ? Icons.thumb_down_alt_rounded
                        : Icons.thumb_down_alt_outlined,
                    color: isDislikedByCurrentUser ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    if (content.type == ContentType.post) {
                      postService.downvotePost(content.id);
                    } else {
                      postService.downvoteComment(content.id);
                    }
                    if (isDislikedByCurrentUser) {
                      setState(() {
                        widget.content.dislikes--;
                        widget.content.dislikeIds.remove(connectedPostState.currentUser.userId);
                      });
                    } else {
                      setState(() {
                        widget.content.dislikes++;
                        widget.content.dislikeIds.add(connectedPostState.currentUser.userId);
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(content.dislikes.toString()),
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
              timeago.format(content.createdDate),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}