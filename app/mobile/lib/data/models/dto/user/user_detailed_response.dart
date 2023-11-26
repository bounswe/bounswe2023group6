import 'package:mobile/data/models/dto/base_dto_object.dart';
import 'package:mobile/utils/service_validation_util.dart';

class UserDetailedDTOResponse extends BaseDTOObject<UserDetailedDTOResponse> {
  final String? about;
  final List<int>? likedPostIds;
  final List<int>? savedPostIds;
  final List<int>? createdPostIds;
  final List<int>? commentedPostIds;
  final List<int>? reportedPostIds;
  final List<int>? blockedPostIds;
  final List<int>? likedGameIds;
  final List<int>? savedGameIds;

  UserDetailedDTOResponse({
    this.about,
    this.likedPostIds,
    this.savedPostIds,
    this.createdPostIds,
    this.commentedPostIds,
    this.reportedPostIds,
    this.blockedPostIds,
    this.likedGameIds,
    this.savedGameIds,
  });

  @override
  void validate() {
    ValidationUtil.validate(about, ValidationPolicy.stringNotEmptyValidation());
  }

  factory UserDetailedDTOResponse.fromJson(Map<String, dynamic> json) =>
      UserDetailedDTOResponse(
        about: json["about"],
        likedPostIds: json["likedPosts"].cast<int>(),
        savedPostIds: json["savedPosts"].cast<int>(),
        createdPostIds: json["createdPosts"].cast<int>(),
        commentedPostIds: json["commentedPosts"].cast<int>(),
        reportedPostIds: json["reportedPosts"].cast<int>(),
        blockedPostIds: json["blockedPosts"].cast<int>(),
        likedGameIds: json["likedGames"].cast<int>(),
        savedGameIds: json["savedGames"].cast<int>(),
      );

  @override
  Map<String, dynamic> toJson() => {
        "about": about,
        "likedPosts": likedPostIds,
        "savedPosts": savedPostIds,
        "createdPosts": createdPostIds,
        "commentedPosts": commentedPostIds,
        "reportedPosts": reportedPostIds,
        "blockedPosts": blockedPostIds,
        "likedGames": likedGameIds,
        "savedGames": savedGameIds,
      };

  @override
  UserDetailedDTOResponse fromJson(Map<String, dynamic> json) =>
      UserDetailedDTOResponse.fromJson(json);
}
