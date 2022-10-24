import 'package:shared_preferences/shared_preferences.dart';

// Use this class for saving or updating values to Shared Preferences.
class SharedPrefs {
  // A Global List of Keys to save the Variables for Shared preferences.
  String id = "id";
  String name = "name";
  String photoUrl = "photoUrl";
  String language = "language";

  void setLanguage(dynamic value){
    save(language, value);
  }

  void setId(dynamic value) {
    save(id, value);
  }

  void setName(dynamic value) {
    save(name, value);
  }

  void setPhotoUrl(dynamic value) {
    save(photoUrl, value);
  }

  dynamic getId() {
    get(id);
  }

  dynamic getName() {
    get(name);
  }

  dynamic getPhotoUrl() {
    get(photoUrl);
  }

  dynamic getLanguage(){
    get(language);
  }

  void save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }

  dynamic get(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }

  bool isSignedUp() {
    dynamic id = getId();
    if (id != null) return true;
    return false;
  }
// TODO: Save the User's Login Information in the SharedPrefs.
// TODO: Save the isfavourite options of the user's products in the phone.
}
