

import 'package:mobile/constants/network_constants.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/dto/content/comment_create_dto_request.dart';
import 'package:mobile/data/models/dto/content/multiple_content_dto_response.dart';
import 'package:mobile/data/models/dto/content/post_report_dto_request.dart';
import 'package:mobile/data/models/dto/content/single_content_dto_response.dart';
import 'package:mobile/data/models/dto/empty_response.dart';
import 'package:mobile/data/models/dto/user/multiple_user_as_dto.dart';
import 'package:mobile/data/models/service_response.dart';
import 'package:mobile/data/services/base_service.dart';

class CommentService {
  static const String serverUrl = NetworkConstants.BASE_LOCAL_URL;

  final BaseNetworkService service = BaseNetworkService();

  CommentService._init();

  static final CommentService _instance = CommentService._init();

  factory CommentService() => _instance;
  static CommentService get instance => _instance;

  static const String _getCommentsForPost = "/comments/post/{id}";
  static const String _createCommentForPost = "/comments/post/{id}";
  static const String _getCommentsForLfg = "/comments/lfg/{id}";
  static const String _createCommentForLfg = "/comments/lfg/{id}";


  static const String _updateComment = "/comments/{id}";
  static const String _deleteComment = "/comments/{id}";
  static const String _reportComment = "/comments/{id}/report";
  static const String _upvoteComment = "/comments/{id}/upvote";
  static const String _downvoteComment = "/comments/{id}/downvote";
  static const String _getLikedUsersForComment = "/comments/{id}/upvotedUsers";
  static const String _getDislikedUsersForComment =
      "/comments/{id}/downvotedUsers";


  Future<Comment> createCommentForPost(
      int relatedPostId, String commentContent, int? parentContentId) async {
    CommentCreateDTORequest commentAsContent = CommentCreateDTORequest(
        content: commentContent, parentContentId: parentContentId);
    ServiceResponse<SingleContentDTO> response = await service
        .sendRequestSafe<CommentCreateDTORequest, SingleContentDTO>(
      _createCommentForPost.replaceFirst('{id}', relatedPostId.toString()),
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

  Future<List<Comment>> getCommentsForPost(int relatedPostId) async {
    ServiceResponse<MultipleContentAsDTO> response = await service
        .sendRequestSafe<MultipleContentAsDTO, MultipleContentAsDTO>(
      _getCommentsForPost.replaceFirst('{id}', relatedPostId.toString()),
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

  Future<Comment> createCommentForLfg(
      int relatedLfgId, String commentContent, int? parentContentId) async {
    CommentCreateDTORequest commentAsContent = CommentCreateDTORequest(
        content: commentContent, parentContentId: parentContentId);
    ServiceResponse<SingleContentDTO> response = await service
        .sendRequestSafe<CommentCreateDTORequest, SingleContentDTO>(
      _createCommentForLfg.replaceFirst('{id}', relatedLfgId.toString()),
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

  Future<List<Comment>> getCommentsForLfg(int relatedLfgId) async {
    ServiceResponse<MultipleContentAsDTO> response = await service
        .sendRequestSafe<MultipleContentAsDTO, MultipleContentAsDTO>(
      _getCommentsForLfg.replaceFirst('{id}', relatedLfgId.toString()),
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

  Future<bool> updateComment(Content commentAsContent) async {
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

}