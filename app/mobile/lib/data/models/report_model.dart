import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/user_model.dart';

class Report {
  final int reportId;
  final String reason;
  User? reportingUser;
  Post? reportedPost;
  Game? reportedGame;
  LFG? reportedLFG;
  Comment? reportedComment;

  Report({
    required this.reportId,
    required this.reason,
    this.reportingUser,
    this.reportedPost,
    this.reportedGame,
    this.reportedLFG,
    this.reportedComment
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['reportId'],
      reason: json['reason'],
      reportingUser: User.fromJson(json['reportingUser']),
      reportedPost: Post.fromJson(json['reportedPost']),
      //reportedGame: Game.fromJson(json['reportedGame']),
      //reportedComment: Comment.fromJson(json['reportedComment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'reason': reason,
      'reportingUser': reportingUser,
      'reportedPost': reportedPost,
      'reportedGame': reportedGame,
      'reportedLFG': reportedLFG,
      'reportedComment': reportedComment,
    };
  }
}