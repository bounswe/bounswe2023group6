import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/user_model.dart';

enum PostCategory { guide, review, discussion }

class Post extends Content {
  final PostCategory? category;
  Post({
    required DateTime createdDate,
    required int id,
    required String content,
    required title,
    required relatedGameId,
    required ownerUserId,
    required ownerUsername,
    required ownerProfileImage,
    // List<String>? annotations,
    required this.category,
    tags,
    likes = 0,
    dislikes = 0,
    comments = 0,
    List<Comment> commentList = const [],
  }) : super(
          createdDate: createdDate,
          id: id,
          content: content,
          type: ContentType.post,
          likes: likes,
          dislikes: dislikes,
          ownerUserId: ownerUserId,
          ownerUsername: ownerUsername,
          ownerProfileImage: ownerProfileImage,
          commentList: commentList,
          comments: comments,
          title: title,
          tags: tags,
          relatedGameId: relatedGameId,
        );

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['postId'],
      title: json['title'],
      content: json['content'],
      createdDate: DateTime.parse(json['creationDate']),
      likes: json['upvotes'],
      dislikes: json['downvotes'],
      comments: json['totalComments'],
      ownerUserId: json['creatorUser']["userId"],
      ownerUsername: json['creatorUser']["username"],
      ownerProfileImage: json['creatorUser']["profilePicture"] ?? "",
      // TODO: change this to more dynamic
      category: json['category'] == "GUIDE"
          ? PostCategory.guide
          : json['category'] == "REVIEW"
              ? PostCategory.review
              : PostCategory.discussion,
      commentList: json.containsKey("comments")
          ? List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x)))
          : [],
      tags: json.containsKey("tags")
          ? List<String>.from(json['tags'].map((x) => x["name"]))
          : [],
      relatedGameId:
          (json.containsKey('relatedGame') && json['relatedGame'] != null)
              ? json['relatedGame']['gameId']
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': id,
      'title': title,
      'content': content,
      'creationDate': createdDate.toString(),
      'upvotes': likes,
      'downvotes': dislikes,
      'creatorUserId': ownerUserId,
      'creatorUsername': ownerUsername,
      'creatorProfileImage': ownerProfileImage,
      'category': category.toString().split('.').last.toUpperCase(),
      'tags': tags,
      // 'comments': commentList.map((x) => x.toJson()),
      // 'relatedGameId': relatedGameId,
    };
  }
}
