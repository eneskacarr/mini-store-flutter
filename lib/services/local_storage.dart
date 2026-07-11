import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  Future<void> saveData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("ls_username", username);
  }

  Future<String?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("ls_username");
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("ls_username");
  }
}