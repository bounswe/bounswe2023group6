import 'package:flutter/material.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/pages/post/post_page.dart';
import 'package:mobile/presentation/pages/post/report_widget.dart';
import 'package:mobile/presentation/pages/post/update_widget.dart';
import 'package:provider/provider.dart';

enum ContentMoreOptions {
  edit,
  delete,
  report,
  reply,
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

    return Card(
      key: !isPost && !isReply 
          ? GlobalObjectKey(content.id)
          : null,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          userInformationSection(context, content.ownerUsername, content.ownerProfileImage, 
            isContentOfOriginalPoster: content.ownerUsername == connectedPostState.post.ownerUsername),
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
                Scrollable.ensureVisible(
                    GlobalObjectKey(parentContent.id).currentContext!,
                    curve: Curves.easeInOut);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: ContentCardWidget(
                  content: parentContent,
                  isReply: true,
                )
              ),
            ),
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
            child: Text(content.content, style: const TextStyle(fontSize: 16)),
          ),
          // Text(post.timeAgo, style: const TextStyle(fontSize: 12,color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1),
          const SizedBox(
            height: 5,
          ),
          !isReply ? contentSocialSection(content) : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget contentMoreOptionsSection(Content content) {
    bool isContentOfCurrentUser = (connectedPostState.currentUser.username == content.ownerUsername);
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
            ).then((value) => {
              setState(() {

              })
            });
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
        }
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ContentMoreOptions>>[
        // if (isContentOfCurrentUser)
        const PopupMenuItem<ContentMoreOptions>(
          value: ContentMoreOptions.edit,
          child: Text('Edit'),
        ),
        // if (isContentOfCurrentUser)
        const PopupMenuItem<ContentMoreOptions>(
          value: ContentMoreOptions.delete,
          child: Text('Delete'),
        ),
        // if (!isContentOfCurrentUser)
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
                } else {
                  postService.upvoteComment(content.id);
                }
                setState(() {
                  widget.content.likes++;                    
                });                
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
                  postService.downvotePost(content.id);
                } else {
                  postService.downvoteComment(content.id);
                }
                setState(() {
                  widget.content.dislikes++;                    
                });                
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
}