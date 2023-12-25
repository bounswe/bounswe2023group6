import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/lfg_service.dart';

class LFG extends Content {
  String? requiredPlatform;
  String? requiredLanguage;
  bool? micCamRequirement;
  int? memberCapacity;
  List<User>? members;

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
    this.members,
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

  factory LFG.fromJson(Map<String, dynamic> json) {
    print(json);
    return LFG(
        id: json['lfgId'],
        title: json['title'],
        description: json['description'],
        ownerUserId: json["user"]["userId"],
        ownerUsername: json["user"]["username"],
        ownerProfileImage: json["user"]["profilePicture"] ?? "",
        creationDate: DateTime.parse(json['creationDate']),
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x["name"]))
            : [],
        relatedGameId:
            json['relatedGame'] != null ? json['relatedGame']["gameId"] : null,
        requiredPlatform: json['requiredPlatform'],
        requiredLanguage: json['requiredLanguage'],
        micCamRequirement: json['micCamRequirement'],
        memberCapacity: json['memberCapacity'],
        members: json["members"] != null
            ? List<User>.from(json["members"].map((x) => User.fromJson(x)))
            : null,
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": content,
      "title": title,
      "ownerUserId": ownerUserId,
      "ownerUsername": ownerUsername,
      "ownerProfileImage": ownerProfileImage,
      "tags": tags,
      "relatedGameId": relatedGameId,
      "likes": likes,
      "dislikes": dislikes,
      "comments": comments,
      "commentList": commentList,
      "requiredPlatform": requiredPlatform,
      "requiredLanguage": requiredLanguage,
      "micCamRequirement": micCamRequirement,
      "memberCapacity": memberCapacity
    };
  }
}
