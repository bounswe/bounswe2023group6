class LFG {
  final int lfgId;
  final String title;
  final String description;
  String? requiredPlatform;
  String? requiredLanguage;
  bool? micCamRequirement;
  int? memberCapacity;
  String? creationDate;

  LFG(
      {required this.lfgId,
      required this.title,
      required this.description,
      this.requiredPlatform,
      this.requiredLanguage,
      this.micCamRequirement,
      this.memberCapacity,
      this.creationDate});
}
