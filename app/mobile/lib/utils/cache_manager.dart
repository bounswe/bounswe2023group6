import 'dart:convert';

import 'package:mobile/utils/shared_manager.dart';

import '../data/models/user_model.dart';

class CacheManager {
  late final SharedManager sharedManager;

  CacheManager(this.sharedManager);

  Future<void> saveUser(User user) async {
    await sharedManager.saveString(SharedKeys.user, jsonEncode(user.toJson()));
  }

  User getUser(){
    return User.fromJson(jsonDecode(sharedManager.getString(SharedKeys.user)))  ;
  }

  Future<bool> removeUser(){
    return sharedManager.removeItem(SharedKeys.user)  ;
  }

  Future<void> saveSessionId(String? sessionId) async {
    await sharedManager.saveString(SharedKeys.sessionId, sessionId ?? "");
  }

  String getSessionId(){
    return sharedManager.getString(SharedKeys.sessionId)  ;
  }

  Future<bool> removeSessionId(){
    return sharedManager.removeItem(SharedKeys.sessionId)  ;
  }
}

