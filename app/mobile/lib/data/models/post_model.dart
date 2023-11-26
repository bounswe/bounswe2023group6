import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/user_model.dart';

class Post extends Content {
  Post({
    required DateTime createdDate,
    required int id,
    required String content,
    required title,
    required relatedGameId, 
    required ownerUserId,
    required ownerUsername,
    required ownerProfileImage,
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
    title: title,
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
      commentList: json.containsKey("comments") 
        ? List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x)))
        : [],
      relatedGameId: json.containsKey("game") 
      ? json['game']['gameId']
      : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': id,
      'title': title,
      'content': content,
      'category': 'DISCUSSION',
      'creationDate': createdDate.toString(),
      'upvotes': likes,
      'downvotes': dislikes,
      'creatorUserId': ownerUserId,
      'creatorUsername': ownerUsername,
      'creatorProfileImage': ownerProfileImage,
      // 'comments': commentList.map((x) => x.toJson()),
      // 'relatedGameId': relatedGameId,
    };
  }
}
