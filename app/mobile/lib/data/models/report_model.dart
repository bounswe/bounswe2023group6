class Report {
  final int reportId;
  final String reason;

  int? commentId;
  int? gameId;
  int? lfgId;
  int? postId;
  int? userId;

  Report({
    required this.reportId,
    required this.reason,
    this.commentId,
    this.gameId,
    this.lfgId,
    this.postId,
    this.userId
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['reportId'],
      reason: json['reason'],
      commentId: json['commentId'],
      gameId: json['gameId'],
      lfgId: json['lfgId'],
      postId: json['postId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'reason': reason,
      'commentId': commentId,
      'gameId': gameId,
      'lfgId': lfgId,
      'postId': postId,
      'userId': userId,
    };
  }
}