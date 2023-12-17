import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/user_model.dart';

class LFG {
  final int lfgId;
  final String title;
  final String description;
  final String? requiredPlatform;
  final String? requiredLanguage;
  final String? micCamRequirement;
  final int? memberCapacity;
  final DateTime? creationDate;
  final user;
  final relatedGame;
  var tags;

  LFG({
    required this.lfgId, 
    required this.title, 
    required this.description, 
    this.requiredPlatform, 
    this.requiredLanguage, 
    this.micCamRequirement, 
    this.memberCapacity, 
    this.creationDate, 
    this.user, 
    this.relatedGame,
  });
}
