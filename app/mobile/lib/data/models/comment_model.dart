import 'package:mobile/data/models/content_model.dart';

class Comment extends Content {
  Comment({
    required DateTime createdDate,
    required int id,
    required String content,
    required int userId,
    required username,
    likes = 0,
    dislikes = 0,
    comments = 0,
  }) : super(
    createdDate: createdDate,
    id: id,
    content: content,
    type: ContentType.comment,
    userId: userId,
    username: username,
    likes: likes,
    dislikes: dislikes,
    comments: comments,
  );  
}