import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/dto/content/comment_create_dto_request.dart';
import 'package:mobile/data/models/dto/content/multiple_content_dto_response.dart';
import 'package:mobile/data/models/dto/content/post_create_dto_request.dart';
import 'package:mobile/data/models/dto/content/post_report_dto_request.dart';
import 'package:mobile/data/models/dto/content/single_content_dto_response.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/user/multiple_user_as_dto.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';

class PostService {
  static const String serverUrl =
      NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  final BaseNetworkService service = BaseNetworkService();

  PostService._init();
  static final PostService _instance = PostService._init();

  factory PostService() => _instance;
  static PostService get instance => _instance;

  static const String _getPosts = "/forum/posts";
  static const String _getPost = "/forum/posts";
  static const String _createPost = "/forum/posts";
  static const String _updatePost = "/forum/posts";
  static const String _deletePost = "/forum/posts";
  static const String _reportPost = "/forum/posts/{id}/report";
  static const String _upvotePost = "/forum/posts/{id}/upvote";
  static const String _downvotePost = "/forum/posts/{id}/downvote";
  static const String _getLikedUsersForPost = "/forum/posts/{id}/upvoteUsers";
  static const String _getDislikedUsersForPost =
      "/forum/posts/{id}/downvoteUsers";

  static const String _getComments = "/comments/post/{id}";
  static const String _createComment = "/comments/post/{id}";
  static const String _updateComment = "/comments/{id}";
  static const String _deleteComment = "/comments/{id}";
  static const String _reportComment = "/comments/{id}/report";
  static const String _upvoteComment = "/comments/{id}/upvote";
  static const String _downvoteComment = "/comments/{id}/downvote";
  static const String _getLikedUsersForComment = "/comments/{id}/upvotedUsers";
  static const String _getDislikedUsersForComment =
      "/comments/{id}/downvotedUsers";

  static const String _getPostsByGame = "/forum/posts/game/{id}";

  Future<List<Post>> getPosts() async {
    if (NetworkConstants.useMockData) {
      return [
        Post(
          createdDate: DateTime.now().subtract(const Duration(hours: 2)),
          id: 1,
          title: 'Epic Battles: The Saga',
          content:
              "Hey, fellow gamers! Just stumbled upon the latest trailer for 'Epic Battles: The Saga,' and I'm mind-blown! The graphics are absolutely jaw-dropping, and the gameplay looks like a total adrenaline rush. I can't wait to get my hands on this game and dive into epic battles of galactic proportions. What are your thoughts? Is",
          ownerUserId: 1,
          ownerUsername: 'GamerXplorer',
          ownerProfileImage: '',
          likes: 23,
          dislikes: 2,
          relatedGameId: 1,
          comments: 8,
          category: PostCategory.review,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 1)),
          id: 2,
          title: 'Galactic Explorers',
          ownerUserId: 2,
          ownerUsername: 'EpicQuestMaster',
          ownerProfileImage: '',
          content:
              "After weeks of traversing the cosmos, I've finally completed 'Galactic Explorers,' and I'm here to share my thoughts. This game is a true cosmic adventure with its vast open-world, stunning visuals, and a captivating storyline. From epic space battles to discovering new alien civilizations",
          likes: 11,
          dislikes: 1,
          relatedGameId: 2,
          comments: 3,
          category: PostCategory.guide,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 2)),
          id: 3,
          title: "Secrets of the Lost Realms",
          ownerUserId: 3,
          ownerUsername: 'MysticalMage',
          ownerProfileImage: '',
          content:
              "I heard a rumor that has it that a mysterious new game, 'Secrets of the Lost Realms,' is in the works. While details are scarce, the anticipation is building ...",
          likes: 5,
          dislikes: 0,
          relatedGameId: 3,
          comments: 1,
          category: PostCategory.discussion,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(hours: 5)),
          id: 4,
          title: 'Captain Thunderstrike in Heroes of Valor',
          ownerUserId: 4,
          ownerUsername: 'PixelAdventurer',
          ownerProfileImage: '',
          content:
              "Heroes come in all forms, but today, let's talk about the charismatic and valiant Captain Thunderstrike from 'Heroes of Valor.' This knight in shining armor ... ",
          likes: 19,
          dislikes: 1,
          relatedGameId: 4,
          comments: 17,
          category: PostCategory.discussion,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(minutes: 12)),
          id: 5,
          title: "Mystic Runes: Enchanted Quest",
          ownerUserId: 5,
          ownerUsername: 'GalaxySeeker',
          ownerProfileImage: '',
          content:
              "Calling all mystic rune enthusiasts! If you're knee-deep in 'Mystic Runes: Enchanted Quest,' here's a pro tip for you. Combine the Fire Rune with the Wind ...",
          likes: 3,
          dislikes: 0,
          relatedGameId: 5,
          comments: 2,
          category: PostCategory.guide,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(hours: 16)),
          id: 6,
          title: 'PixelCon 2023 is coming!',
          ownerUserId: 6,
          ownerUsername: 'NinjaPlayer27',
          ownerProfileImage: '',
          content:
              "Attention all gamers, mark your calendars because 'PixelCon 2023' is just around the corner! Get ready for the ultimate gaming extravaganza filled with ...",
          likes: 27,
          dislikes: 3,
          relatedGameId: 6,
          comments: 10,
          category: PostCategory.discussion,
        ),
      ];
    }

    ServiceResponse<MultipleContentAsDTO> response = await service
        .sendRequestSafe<MultipleContentAsDTO, MultipleContentAsDTO>(
      _getPosts,
      null,
      MultipleContentAsDTO(),
      'GET',
    );
    if (response.success) {
      List<Post> posts = response.responseConverted!.posts!
          .map((e) => e.content! as Post)
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> getPost(int postId) async {
    if (NetworkConstants.useMockData) {
      List<Post> posts = await getPosts();
      return posts.firstWhere((element) => element.id == postId);
    }

    ServiceResponse<SingleContentDTO> response =
        await service.sendRequestSafe<EmptyResponse, SingleContentDTO>(
      "$_getPost/$postId",
      null,
      SingleContentDTO(),
      'GET',
    );
    if (response.success) {
      Post post = response.responseConverted!.content! as Post;
      return post;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Post> createPost(
    String title,
    String content,
    int relatedGameId,
    String postCategory,
    List<String> tags,
  ) async {
    if (NetworkConstants.useMockData) {
      return Post(
        id: 1,
        title: title,
        content: content,
        ownerUserId: 1,
        ownerUsername: 'user1',
        ownerProfileImage: '',
        createdDate: DateTime.now(),
        likes: 0,
        dislikes: 0,
        comments: 0,
        relatedGameId: null,
        category: PostCategory.discussion,
      );
    }

    PostCreateDTORequest postCreateDTORequest = PostCreateDTORequest(
      title: title,
      content: content,
      relatedGameId: relatedGameId,
      category: postCategory,
      tags: tags,
    );
    ServiceResponse<SingleContentDTO> response =
        await service.sendRequestSafe<PostCreateDTORequest, SingleContentDTO>(
      _createPost,
      postCreateDTORequest,
      SingleContentDTO(),
      'POST',
    );
    if (response.success) {
      Post createdPost = response.responseConverted!.content! as Post;
      return createdPost;
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<bool> updatePost(Content postAsContent) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    SingleContentDTO postUpdateDTORequest = SingleContentDTO(
      content: postAsContent,
    );
    final response =
        await service.sendRequestSafe<SingleContentDTO, EmptyResponse>(
      "$_updatePost/${postAsContent.id}",
      postUpdateDTORequest,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<bool> deletePost(int id) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      "$_deletePost/$id",
      null,
      EmptyResponse(),
      'DELETE',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<bool> reportPost(int postId, String reason, String description) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    PostReportDTORequest postReportDTORequest =
        PostReportDTORequest(reason: "$reason : $description");
    final response =
        await service.sendRequestSafe<PostReportDTORequest, EmptyResponse>(
      _reportPost.replaceFirst('{id}', postId.toString()),
      postReportDTORequest,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to report post');
    }
  }

  Future<bool> upvotePost(int postId) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      _upvotePost.replaceFirst('{id}', postId.toString()),
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> downvotePost(int postId) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      _downvotePost.replaceFirst('{id}', postId.toString()),
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<int>> getLikedUsersForPost(int postId) async {
    if (NetworkConstants.useMockData) {
      return [1, 2, 3];
    }

    ServiceResponse<MultipleUserAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleUserAsDTO>(
      _getLikedUsersForPost.replaceFirst('{id}', postId.toString()),
      null,
      MultipleUserAsDTO(),
      'GET',
    );
    if (response.success) {
      List<int> userIds = response.responseConverted!.users!
          .map((e) => e.user!.userId)
          .toList();
      return userIds;
    } else {
      throw Exception('Failed to load liked users for post');
    }
  }

  Future<List<int>> getDislikedUsersForPost(int postId) async {
    if (NetworkConstants.useMockData) {
      return [4, 5, 6];
    }

    ServiceResponse<MultipleUserAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleUserAsDTO>(
      _getDislikedUsersForPost.replaceFirst('{id}', postId.toString()),
      null,
      MultipleUserAsDTO(),
      'GET',
    );
    if (response.success) {
      List<int> userIds = response.responseConverted!.users!
          .map((e) => e.user!.userId)
          .toList();
      return userIds;
    } else {
      throw Exception('Failed to load disliked users for post');
    }
  }

  Future<List<Comment>> getComments(int relatedPostId) async {
    if (NetworkConstants.useMockData) {
      return [
        Comment(
          createdDate: DateTime.now(),
          id: 1,
          content: 'This is a comment',
          ownerUserId: 1,
          ownerUsername: 'user1',
          ownerProfileImage: '',
          likes: 1,
          dislikes: 0,
        ),
        Comment(
          createdDate: DateTime.now().subtract(const Duration(days: 1)),
          id: 2,
          content: 'This is another comment',
          ownerUserId: 2,
          ownerUsername: 'user2',
          ownerProfileImage: '',
          likes: 0,
          dislikes: 1,
        ),
        Comment(
          createdDate: DateTime.now().subtract(const Duration(days: 3)),
          id: 3,
          content: 'This is a third comment',
          ownerUserId: 3,
          ownerUsername: 'user3',
          ownerProfileImage: '',
          likes: 0,
          dislikes: 0,
        ),
      ];
    }

    ServiceResponse<MultipleContentAsDTO> response = await service
        .sendRequestSafe<MultipleContentAsDTO, MultipleContentAsDTO>(
      _getComments.replaceFirst('{id}', relatedPostId.toString()),
      null,
      MultipleContentAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Comment> comments = response.responseConverted!.posts!
          .map((e) => e.content! as Comment)
          .toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Comment> createComment(
      int relatedPostId, String commentContent, int? parentContentId) async {
    if (NetworkConstants.useMockData) {
      return Comment(
        id: 1,
        content: commentContent,
        ownerUserId: 1,
        ownerUsername: 'user1',
        ownerProfileImage: '',
        createdDate: DateTime.now(),
        likes: 0,
        dislikes: 0,
      );
    }

    CommentCreateDTORequest commentAsContent = CommentCreateDTORequest(
        content: commentContent, parentContentId: parentContentId);
    ServiceResponse<SingleContentDTO> response = await service
        .sendRequestSafe<CommentCreateDTORequest, SingleContentDTO>(
      _createComment.replaceFirst('{id}', relatedPostId.toString()),
      commentAsContent,
      SingleContentDTO(),
      'POST',
    );
    if (response.success) {
      Comment createdComment = response.responseConverted!.content! as Comment;
      return createdComment;
    } else {
      throw Exception('Failed to create comment');
    }
  }

  Future<bool> updateComment(Content commentAsContent) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    SingleContentDTO commentAsContentDTO = SingleContentDTO(
      content: commentAsContent,
    );
    final response =
        await service.sendRequestSafe<SingleContentDTO, EmptyResponse>(
      _updateComment.replaceFirst('{id}', commentAsContent.id.toString()),
      commentAsContentDTO,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to update comment');
    }
  }

  Future<bool> deleteComment(int id) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      _deleteComment.replaceFirst('{id}', id.toString()),
      null,
      EmptyResponse(),
      'DELETE',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to delete comment');
    }
  }

  Future<bool> reportComment(
      int commentId, String reason, String description) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    PostReportDTORequest commentReportDTORequest = PostReportDTORequest(
      reason: "$reason : $description",
    );
    final response =
        await service.sendRequestSafe<PostReportDTORequest, EmptyResponse>(
      _reportComment.replaceFirst('{id}', commentId.toString()),
      commentReportDTORequest,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to report comment');
    }
  }

  Future<bool> upvoteComment(int commentId) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      _upvoteComment.replaceFirst('{id}', commentId.toString()),
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to upvote comment');
    }
  }

  Future<bool> downvoteComment(int commentId) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    final response =
        await service.sendRequestSafe<EmptyResponse, EmptyResponse>(
      _downvoteComment.replaceFirst('{id}', commentId.toString()),
      null,
      EmptyResponse(),
      'PUT',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to downvote comment');
    }
  }

  Future<List<int>> getLikedUsersForComment(int commentId) async {
    if (NetworkConstants.useMockData) {
      return [1, 2, 3];
    }

    ServiceResponse<MultipleUserAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleUserAsDTO>(
      _getLikedUsersForComment.replaceFirst('{id}', commentId.toString()),
      null,
      MultipleUserAsDTO(),
      'GET',
    );
    if (response.success) {
      List<int> userIds = response.responseConverted!.users!
          .map((e) => e.user!.userId)
          .toList();
      return userIds;
    } else {
      throw Exception('Failed to load liked users for comment');
    }
  }

  Future<List<int>> getDislikedUsersForComment(int commentId) async {
    if (NetworkConstants.useMockData) {
      return [4, 5, 6];
    }

    ServiceResponse<MultipleUserAsDTO> response =
        await service.sendRequestSafe<EmptyResponse, MultipleUserAsDTO>(
      _getDislikedUsersForComment.replaceFirst('{id}', commentId.toString()),
      null,
      MultipleUserAsDTO(),
      'GET',
    );
    if (response.success) {
      List<int> userIds = response.responseConverted!.users!
          .map((e) => e.user!.userId)
          .toList();
      return userIds;
    } else {
      throw Exception('Failed to load disliked users for comment');
    }
  }

  Future<List<Post>> getPostsByGame(int gameId) async {
    ServiceResponse<MultipleContentAsDTO> response = await service
        .sendRequestSafe<MultipleContentAsDTO, MultipleContentAsDTO>(
      _getPostsByGame.replaceFirst('{id}', gameId.toString()),
      null,
      MultipleContentAsDTO(),
      'GET',
    );

    if (response.success) {
      List<Post> posts = response.responseConverted!.posts!
          .map((e) => e.content! as Post)
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load posts by game');
    }
  }
}
