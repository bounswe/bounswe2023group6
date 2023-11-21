import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/dto/content/post_create_dto_request.dart';
import 'package:mobile/data/models/dto/content/post_create_dto_response.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';


class PostService {
  static const String serverUrl =
    NetworkConstants.BASE_LOCAL_URL; // Replace with your server's URL

  final BaseNetworkService service = BaseNetworkService();

  // static const String _getPosts = "/posts";
  static const String _createPost = "/posts";
  // static const String _updatePost = "/update_post";
  // static const String _deletePost = "/delete_post";
  // static const String _reportPost = "/report_post";
  // static const String _upvotePost = "/upvote_post";
  // static const String _downvotePost = "/downvote_post";

  // static const String _getComments = "/comments/post/";
  // static const String _createComment = "/create_comment";
  // static const String _updateComment = "/update_comment";
  // static const String _deleteComment = "/delete_comment";
  // static const String _reportComment = "/report_comment";
  // static const String _upvoteComment = "/upvote_comment";
  // static const String _downvoteComment = "/downvote_comment";

  
  Future<List<Post>> getPosts() async {
    // final response = await service.sendRequestSafe<MultiplePostsDTOModel, MultiplePostsDTOModel>(
    //   _getPosts,
    //   null,
    //   MultiplePostsDTOModel(),
    //   'GET',
    // );
    // if (response.success) {
      // return response.response!.posts;
    if (NetworkConstants.useMockData) {
      return [
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 1)),          
          id: 1,
          content: 'This is a post',
          userId: 1,
          username: 'user1',
          title: 'Post 1',
          likes: 1,
          dislikes: 0,
          comments: 1,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 2)),
          id: 2,
          content: 'This is another post',
          userId: 2,
          username: 'user2',
          title: 'Post 2',
          likes: 0,
          dislikes: 1,
          comments: 0,
        ),
        Post(
          createdDate: DateTime.now().subtract(const Duration(days: 3)),
          id: 3,
          content: 'This is a third post',
          userId: 3,
          username: 'user3',
          title: 'Post 3',
          likes: 0,
          dislikes: 0,
          comments: 0,
        ),
      ];
    } else {
      throw Exception('Failed to load posts');
    }

  }

  Future<Post> createPost(String title, String content) async {
    if (NetworkConstants.useMockData) {
      return Post(
        id: 1,
        title: title,
        content: content,
        userId: 0,
        username: 'user1',
        createdDate: DateTime.now(),
        likes: 0,
        dislikes: 0,
        comments: 0,
      );
    }
    
    PostCreateDTORequest postCreateDTORequest = PostCreateDTORequest(
      title: title,
      content: content,
    );
    ServiceResponse response = await service.sendRequestSafe<PostCreateDTORequest, PostCreateDtoResponse>(
      _createPost,
      postCreateDTORequest,
      PostCreateDtoResponse(),
      'POST',
    );
    if (response.success) {
      PostCreateDtoResponse postCreateDtoResponse = response.responseConverted;
      Post createdPost = Post(
        id: postCreateDtoResponse.id!,
        title: postCreateDtoResponse.title,
        content: postCreateDtoResponse.content!,
        // userId: postCreateDtoResponse.ownerUser.id,
        userId: 0,
        username: postCreateDtoResponse.ownerUser?.name,
        createdDate: postCreateDtoResponse.createdAt!,
        likes: 0,
        dislikes: 0,
        comments: 0,
      );
      
      return createdPost;
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<bool> updatePost(Content postAsContent) async {
    // final response = await service.sendRequestSafe<PostUpdateDTORequest, PostUpdateDTOResponse>(
    //   _updatePost,
    //   null,
    //   PostUpdateDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    //   return true;
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<bool> deletePost(int id) async {
    // final response = await service.sendRequestSafe<PostDeleteDTORequest, PostDeleteDTOResponse>(
    //   _deletePost,
    //   null,
    //   PostDeleteDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    //   return true;
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<bool> reportPost(int postId, String reason) async {
    // final response = await service.sendRequestSafe<PostReportDTORequest, PostReportDTOResponse>(
    //   _reportPost,
    //   null,
    //   PostReportDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    //   return true;
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to report post');
    }
  }

  Future<bool> upvotePost(int postId) async {
    // final response = await service.sendRequestSafe<PostUpvoteDTORequest, PostUpvoteDTOResponse>(
    //   _upvotePost,
    //   null,
    //   PostUpvoteDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
      return true;
    } else {
      throw Exception('Failed to upvote post');
    }
  }

  Future<bool> downvotePost(int postId) async {
    // final response = await service.sendRequestSafe<PostDownvoteDTORequest, PostDownvoteDTOResponse>(
    //   _downvotePost,
    //   null,
    //   PostDownvoteDTOResponse(),
    //   'POST',
    // );
    // if (response.success) {
    if (NetworkConstants.useMockData) {
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
          userId: 1,
          username: 'user1',
          likes: 1,
          dislikes: 0,
          comments: 1,
        ),
        Comment(
          createdDate: DateTime.now().subtract(const Duration(days: 1)),
          id: 2,
          content: 'This is another comment',
          userId: 2,
          username: 'user2',
          likes: 0,
          dislikes: 1,
          comments: 0,
        ),
        Comment(
          createdDate: DateTime.now().subtract(const Duration(days: 3)),
          id: 3,
          content: 'This is a third comment',
          userId: 3,
          username: 'user3',
          likes: 0,
          dislikes: 0,
          comments: 0,
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