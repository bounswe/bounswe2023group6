
import 'package:shared_preferences/shared_preferences.dart';

enum SharedKeys {
  user,
  sessionId
}

class SharedManager {
  SharedManager._init() {
    // SharedPreferences.getInstance().then((value) => preferences = value);
  }
  
  factory SharedManager() => _instance;
  static final SharedManager _instance = SharedManager._init();

  SharedPreferences? preferences;

  Future<void> initializePreferences() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> saveString(SharedKeys key, String value) async {
    await preferences?.setString(key.name, value);
  }

  Future<void> saveStringItems(SharedKeys key, List<String> value) async {
    await preferences?.setStringList(key.name, value);
  }

  bool checkString(SharedKeys key) {
    return preferences?.containsKey(key.name) ?? false;
  }

  String getString(SharedKeys key) {
    return (preferences?.getString(key.name))!;
  }

  Future<List<String>?> getStringItems(SharedKeys key) async {
    return preferences?.getStringList(key.name);
  }

  Future<bool> removeItem(SharedKeys key) async {
    return (await preferences?.remove(key.name)) ?? false;
  }

}