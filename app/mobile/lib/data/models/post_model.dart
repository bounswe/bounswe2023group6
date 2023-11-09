class Post {
  final int id;
  final String title;
  final String content;
  final int userId;

  String? username; 
  int likes = 0;
  int dislikes = 0;
  int comments = 0;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    this.username,
    this.likes = 0,
    this.dislikes = 0,
    this.comments = 0,
  });
}
