import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/dto/content/multiple_posts_dto_response.dart';
import 'package:mobile/data/models/dto/content/post_create_dto_request.dart';
import 'package:mobile/data/models/dto/content/post_id_dto_request.dart';
import 'package:mobile/data/models/dto/content/post_report_dto_request.dart';
import 'package:mobile/data/models/dto/content/post_update_dto_request.dart';
import 'package:mobile/data/models/dto/content/single_post_dto_response.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/base_service.dart';

class PostService {
  static const String serverUrl =
      NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  final BaseNetworkService service = BaseNetworkService();

  static const String _getPosts = "/posts";
  static const String _getPost = "/posts";
  static const String _createPost = "/posts";
  static const String _updatePost = "/posts";
  static const String _deletePost = "/posts";
  static const String _reportPost = "/report_post";
  static const String _upvotePost = "/upvote_post";
  static const String _downvotePost = "/downvote_post";

  // static const String _getComments = "/comments/post/";
  // static const String _createComment = "/create_comment";
  // static const String _updateComment = "/update_comment";
  // static const String _deleteComment = "/delete_comment";
  // static const String _reportComment = "/report_comment";
  // static const String _upvoteComment = "/upvote_comment";
  // static const String _downvoteComment = "/downvote_comment";

  Future<List<Post>> getPosts() async {
    if (NetworkConstants.useMockData) {
      return [
        Post(
          createdDate: DateTime.now().subtract(const Duration(hours: 2)),
          id: 1,
          title: 'Epic Battles: The Saga',
          content:
              "Hey, fellow gamers! Just stumbled upon the latest trailer for 'Epic Battles: The Saga,' and I'm mind-blown! The graphics are absolutely jaw-dropping, and the gameplay looks like a total adrenaline rush. I can't wait to get my hands on this game and dive into epic battles of galactic proportions. What are your thoughts? Is",
          ownerUser: User(
            name: 'user1',
            surname: 'user1',
            email: '',
            username: 'GamerXplorer',
          ),
          likes: 23,
          dislikes: 2,
          relatedGameId: 1,
          comments: 8,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 1)),
          id: 2,
          title: 'Galactic Explorers',
          ownerUser: User(
              name: 'user2',
              surname: 'user2',
              email: '',
              username: 'EpicQuestMaster'),
          content:
              "After weeks of traversing the cosmos, I've finally completed 'Galactic Explorers,' and I'm here to share my thoughts. This game is a true cosmic adventure with its vast open-world, stunning visuals, and a captivating storyline. From epic space battles to discovering new alien civilizations",
          likes: 11,
          dislikes: 1,
          relatedGameId: 2,
          comments: 3,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 2)),
          id: 3,
          title: "Secrets of the Lost Realms",
          ownerUser: User(
            name: 'user3',
            surname: 'user3',
            email: '',
            username: 'MysticalMage',
          ),
          content:
              "I heard a rumor that has it that a mysterious new game, 'Secrets of the Lost Realms,' is in the works. While details are scarce, the anticipation is building ...",
          likes: 5,
          dislikes: 0,
          relatedGameId: 3,
          comments: 1,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(hours: 5)),
          id: 4,
          title: 'Captain Thunderstrike in Heroes of Valor',
          ownerUser: User(
            name: 'user4',
            surname: 'user4',
            email: '',
            username: 'PixelAdventurer',
          ),
          content:
              "Heroes come in all forms, but today, let's talk about the charismatic and valiant Captain Thunderstrike from 'Heroes of Valor.' This knight in shining armor ... ",
          likes: 19,
          dislikes: 1,
          relatedGameId: 4,
          comments: 17,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(minutes: 12)),
          id: 5,
          title: "Mystic Runes: Enchanted Quest",
          ownerUser: User(
            name: 'user5',
            surname: 'user5',
            email: '',
            username: 'GalaxySeeker',
          ),
          content:
              "Calling all mystic rune enthusiasts! If you're knee-deep in 'Mystic Runes: Enchanted Quest,' here's a pro tip for you. Combine the Fire Rune with the Wind ...",
          likes: 3,
          dislikes: 0,
          relatedGameId: 5,
          comments: 2,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(hours: 16)),
          id: 6,
          title: 'PixelCon 2023 is coming!',
          ownerUser: User(
            name: 'user6',
            surname: 'user6',
            email: '',
            username: 'NinjaPlayer27',
          ),
          content:
              "Attention all gamers, mark your calendars because 'PixelCon 2023' is just around the corner! Get ready for the ultimate gaming extravaganza filled with ...",
          likes: 27,
          dislikes: 3,
          relatedGameId: 6,
          comments: 10,
        ),
      ];
    }

    ServiceResponse<MultiplePostAsDTO> response =
        await service.sendRequestSafe<MultiplePostAsDTO, MultiplePostAsDTO>(
      _getPosts,
      null,
      MultiplePostAsDTO(),
      'GET',
    );
    if (response.success) {
      List<Post> posts =
          response.responseConverted!.posts!.map((e) => e.post!).toList();
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

    PostIdDTORequest postIdDTORequest = PostIdDTORequest(postId: postId);
    ServiceResponse<SinglePostDTO> response =
        await service.sendRequestSafe<PostIdDTORequest, SinglePostDTO>(
      _getPosts,
      postIdDTORequest,
      SinglePostDTO(),
      'GET',
    );
    if (response.success) {
      Post post = response.responseConverted!.post!;
      return post;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Post> createPost(String title, String content) async {
    if (NetworkConstants.useMockData) {
      return Post(
        id: 1,
        title: title,
        content: content,
        ownerUser: User(
          name: 'user1',
          surname: 'user1',
          email: '',
          username: 'user1',
        ),
        createdDate: DateTime.now(),
        likes: 0,
        dislikes: 0,
        comments: 0,
        relatedGameId: null,
      );
    }

    PostCreateDTORequest postCreateDTORequest = PostCreateDTORequest(
      title: title,
      content: content,
    );
    ServiceResponse<SinglePostDTO> response =
        await service.sendRequestSafe<PostCreateDTORequest, SinglePostDTO>(
      _createPost,
      postCreateDTORequest,
      SinglePostDTO(),
      'POST',
    );
    if (response.success) {
      Post createdPost = response.responseConverted!.post!;
      return createdPost;
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<bool> updatePost(Post updatedPost) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    PostUpdateDTORequest postUpdateDTORequest = PostUpdateDTORequest(
      postId: updatedPost.id,
      updatedPost: SinglePostDTO(post: updatedPost)
    );
    final response = await service
        .sendRequestSafe<PostUpdateDTORequest, SinglePostDTO>(
      _updatePost,
      postUpdateDTORequest,
      SinglePostDTO(),
      'POST',
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

    PostIdDTORequest postIdDTORequest = PostIdDTORequest(postId: id);
    final response =
        await service.sendRequestSafe<PostIdDTORequest, EmptyResponse>(
      _deletePost,
      postIdDTORequest,
      EmptyResponse(),
      'POST',
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

    PostReportDTORequest postReportDTORequest = PostReportDTORequest(
        postId: postId, reason: reason, description: description);
    final response =
        await service.sendRequestSafe<PostReportDTORequest, EmptyResponse>(
      _reportPost,
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

    PostIdDTORequest postIdDTORequest = PostIdDTORequest(postId: postId);
    final response =
        await service.sendRequestSafe<PostIdDTORequest, EmptyResponse>(
      _upvotePost,
      postIdDTORequest,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to upvote post');
    }
  }

  Future<bool> downvotePost(int postId) async {
    if (NetworkConstants.useMockData) {
      return true;
    }

    PostIdDTORequest postIdDTORequest = PostIdDTORequest(postId: postId);
    final response =
        await service.sendRequestSafe<PostIdDTORequest, EmptyResponse>(
      _downvotePost,
      postIdDTORequest,
      EmptyResponse(),
      'POST',
    );
    if (response.success) {
      return true;
    } else {
      throw Exception('Failed to downvote post');
    }
  }

  Future<List<Comment>> getComments(int relatedPostId) async {
    // final response = await service.sendRequestSafe<MultipleCommentsDTOModel, MultipleCommentsDTOModel>(
    //   _getComments,
    //   null,
    //   MultipleCommentsDTOModel(),
    //   'GET',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return [
        Comment(
          createdDate: DateTime.now(),
          id: 1,
          content: 'This is a comment',
          ownerUser: User(
            name: 'user1',
            surname: 'user1',
            email: '',
            username: 'user1',
          ),
          likes: 1,
          dislikes: 0,
        ),
        Comment(
          createdDate: DateTime.now().subtract(const Duration(days: 1)),
          id: 2,
          content: 'This is another comment',
          ownerUser: User(
            name: 'user2',
            surname: 'user2',
            email: '',
            username: 'user2',
          ),
          likes: 0,
          dislikes: 1,
        ),
        Comment(
          createdDate: DateTime.now().subtract(const Duration(days: 3)),
          id: 3,
          content: 'This is a third comment',
          ownerUser: User(
            name: 'user3',
            surname: 'user3',
            email: '',
            username: 'user3',
          ),
          likes: 0,
          dislikes: 0,
        ),
      ];
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<bool> createComment(int relatedPostId, Comment comment) async {
    // final response = await service.sendRequestSafe<CommentCreateDTORequest, CommentCreateDTOResponse>(
    //   _createComment,
    //   null,
    //   CommentCreateDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to create comment');
    }
  }

  Future<bool> updateComment(Content commentAsContent) async {
    // final response = await service.sendRequestSafe<CommentUpdateDTORequest, CommentUpdateDTOResponse>(
    //   _updateComment,
    //   null,
    //   CommentUpdateDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to update comment');
    }
  }

  Future<bool> deleteComment(int id) async {
    // final response = await service.sendRequestSafe<CommentDeleteDTORequest, CommentDeleteDTOResponse>(
    //   _deleteComment,
    //   null,
    //   CommentDeleteDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to delete comment');
    }
  }

  Future<bool> reportComment(int commentId, String reason) async {
    // final response = await service.sendRequestSafe<CommentReportDTORequest, CommentReportDTOResponse>(
    //   _reportComment,
    //   null,
    //   CommentReportDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to report comment');
    }
  }

  Future<bool> upvoteComment(int commentId) async {
    // final response = await service.sendRequestSafe<CommentUpvoteDTORequest, CommentUpvoteDTOResponse>(
    //   _upvoteComment,
    //   null,
    //   CommentUpvoteDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to upvote comment');
    }
  }

  Future<bool> downvoteComment(int commentId) async {
    // final response = await service.sendRequestSafe<CommentDownvoteDTORequest, CommentDownvoteDTOResponse>(
    //   _downvoteComment,
    //   null,
    //   CommentDownvoteDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to downvote comment');
    }
  }
}
