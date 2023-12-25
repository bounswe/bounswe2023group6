import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/services/lfg_service.dart';

class LFG extends Content {
  String? requiredPlatform;
  String? requiredLanguage;
  bool? micCamRequirement;
  int? memberCapacity;

  LFG({
    required int id,
    required String title,
    required String description,
    required int ownerUserId,
    required String ownerUsername,
    required String ownerProfileImage,
    required DateTime creationDate,
    annotations = const [],
    tags,
    relatedGameId,
    likes = 0,
    dislikes = 0,
    comments = 0,
    List<Comment> commentList = const [],

    this.requiredPlatform,
    this.requiredLanguage,
    this.micCamRequirement,
    this.memberCapacity,
  }) : super(
          id: id,
          content: description,
          type: ContentType.lfg,
          ownerUserId: ownerUserId,
          ownerUsername: ownerUsername,
          ownerProfileImage: ownerProfileImage,
          createdDate: creationDate,
          likes: likes,
          dislikes: dislikes,
          comments: comments,
          commentList: commentList,
          title: title,
          tags: tags,
          relatedGameId: relatedGameId,
        );
  
  Future<void> loadLfgSocialData() async {
    LFGService lfgService = LFGService();
    likeIds = await lfgService.getLikedUsers(id);
    dislikeIds = await lfgService.getDislikedUsers(id);
  }
}
