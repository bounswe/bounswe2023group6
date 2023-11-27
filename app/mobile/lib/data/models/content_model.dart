import 'package:flutter/material.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/post_service.dart';
import 'package:mobile/presentation/widgets/avatar_widget.dart';

enum ContentType { post, comment, lfg }

class Content {
  final DateTime createdDate;
  final int id;
  String content;
  final ContentType type;
  // User? ownerUser;
  final int ownerUserId;
  final String ownerUsername;
  final String ownerProfileImage;

  // final int userId;
  // final String username;
  // final List<String>? annotations;
  // final List<String>? tags;
  // final List<Report> reports;
  // final List<Content>? relatedContent;
  // final List<Content>? relatedGames;
  // final List<Content>? relatedUsers;

  int likes;
  int dislikes;
  int comments;
  int shares;
  int views;

  List<int> likeIds = [];
  List<int> dislikeIds = [];
  List<int> commentIds = [];

  List<Comment> commentList = [];
  int? parentContentId;

  int? relatedGameId;
  String? title; // For post and lfg

  GlobalObjectKey globalKey = GlobalObjectKey(UniqueKey());

  Content({
    required this.id,
    required this.content,
    required this.type,
    required this.ownerUserId,
    required this.ownerUsername,
    required this.ownerProfileImage,
    required this.createdDate,
    // this.annotations,
    // this.tags,
    // this.reports,
    // this.relatedContent,
    // this.relatedGames,
    // this.relatedUsers,
    this.title,
    this.likes = 0,
    this.dislikes = 0,
    this.shares = 0,
    this.views = 0,
    this.parentContentId,
    this.relatedGameId,
    this.comments = 0,
    this.commentList = const [],
  });

  Future<void> loadContentSocialData() async {
    PostService postService = PostService();
    if (type == ContentType.post) {
      likeIds = await postService.getLikedUsersForPost(id);
      dislikeIds = await postService.getDislikedUsersForPost(id);
    } else {
      likeIds = await postService.getLikedUsersForComment(id);
      dislikeIds = await postService.getDislikedUsersForComment(id);
    }
  }
}

// Content related widgets
Widget userInformationSection(
    BuildContext context, String username, String profileImage,
    {bool isContentOfOriginalPoster = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          // user.profileImage != null
          //     ? DisplayAvatar(
          //         byteData: user.profileImage,
          //         onPressed: () {
          //           // go to profile page
          //           Navigator.pushNamed(context, '/profile', arguments: username);
          //         },
          //       )
          //     : const Icon(Icons.account_circle),
          IconButton(
            onPressed: () {
              // go to profile page
              Navigator.pushNamed(context, '/profile', arguments: username);
            },
            icon: const Icon(Icons.account_circle),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(username, style: const TextStyle(fontSize: 13)),
              ),
            ),
          ),
          isContentOfOriginalPoster
              // Show original poster tag(in a colored button) if content is of original poster
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Original Poster',
                        style: TextStyle(
                            fontSize: 13, color: Theme.of(context).cardColor)),
                  ),
                )
              : Container(),
        ],
      ),
    ],
  );
}
