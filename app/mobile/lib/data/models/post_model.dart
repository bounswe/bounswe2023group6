import 'package:mobile/data/models/content_model.dart';

class Post extends Content {
  Post({
    required DateTime createdDate,
    required int id,
    required String content,
    required int userId,
    required username,
    required title,
    likes = 0,
    dislikes = 0,
    comments = 0,
  }) : super(
    createdDate: createdDate,
    id: id,
    content: content,
    type: ContentType.post,
    userId: userId,
    likes: likes,
    dislikes: dislikes,
    comments: comments,
    title: title,
    username: username, 
  );
}
