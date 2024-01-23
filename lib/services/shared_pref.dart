import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  // Singleton instance
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  late SharedPreferences _prefs;

  factory SharedPreferencesManager() {
    return _instance;
  }

  SharedPreferencesManager._internal();

  static const String favKey = "fav";

  // Initialize SharedPreferences asynchronously
  Future<void> init() async {
    _prefs = await _initPrefs();
  }

  // Private method to initialize SharedPreferences
  Future<SharedPreferences> _initPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// Display Highlights
  List<String> getFavKey() {
    return _prefs.getStringList(favKey) ?? [];
  }

  Future<void> delFavKey(String key) async {
    List<String> l = getFavKey();
    l.remove(key);
    await _prefs.setStringList(favKey, l);
  }

  Future<void> addFavKey(String key) async {
    List<String> l = getFavKey();
    l.add(key);
    await _prefs.setStringList(favKey, l);
  }

  bool isFavKey(String key) {
    List<String> l = getFavKey();
    if (l.contains(key)) {
      return true;
    }
    return false;
  }
}
