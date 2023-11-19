import 'dart:convert';

import 'package:mobile/utils/shared_manager.dart';

import '../data/models/user_model.dart';

class UserCacheManager {
  late final SharedManager sharedManager;

  UserCacheManager(this.sharedManager);

  Future<void> saveUser(User user) async {
    await sharedManager.saveString(SharedKeys.user, jsonEncode(user.toJson()));
  }

  User getUser(){
    return User.fromJson(jsonDecode(sharedManager.getString(SharedKeys.user)))  ;
  }
}