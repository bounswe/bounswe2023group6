import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/user_model.dart';

class Post extends Content {
  Post({
    required DateTime createdDate,
    required int id,
    required String content,
    required ownerUser,
    required title,
    required relatedGameId, 
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
    ownerUser: ownerUser,
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
      ownerUser: User.fromJson(json['user']), 
      commentList: List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x))),
      relatedGameId: json['game']['gameId'],
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
      'user': ownerUser.toJson(),
      'comments': commentList.map((x) => x.toJson()),
      'game': {
        'gameId': relatedGameId,
      },
    };
  }
}
