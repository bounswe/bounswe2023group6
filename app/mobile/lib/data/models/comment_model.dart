import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/user_model.dart';

class Comment extends Content {
  Comment({
    required DateTime createdDate,
    required int id,
    required String content,
    required ownerUser,
    parentContentId,
    relatedGameId, 
    likes = 0,
    dislikes = 0,
  }) : super(
    createdDate: createdDate,
    id: id,
    content: content,
    type: ContentType.comment,
    ownerUser: ownerUser,
    parentContentId: parentContentId,
    likes: likes,
    dislikes: dislikes,
    relatedGameId: relatedGameId,
  );  

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['commentId'],
      content: json['content'],
      createdDate: DateTime.parse(json['creationDate']),
      likes: json['upvotes'],
      dislikes: json['downvotes'],
      ownerUser: User.fromJson(json['user']), 
      parentContentId:  json.containsKey('parentContentId') ? json['parentContentId'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': id,
      'content': content,
      'creationDate': createdDate.toString(),
      'upvotes': likes,
      'downvotes': dislikes,
      'user': ownerUser.toJson(),
      'comments': comments,
      'parentContentId': parentContentId,
      'game': {
        'gameId': relatedGameId,
      },
    };
  }
}