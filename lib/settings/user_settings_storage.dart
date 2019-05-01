import 'dart:async';
import '../bug/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsStorage {

  static Future<User> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('user_id') ?? "");
    String userName = (prefs.getString('user_name') ?? "");

    User user = new User(userId, userName);
    return user;
  }

  static Future<void> save(User user) async {
    print("Saving User settings");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.getId());
    await prefs.setString('user_name', user.getName());
  }
}