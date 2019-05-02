import 'dart:convert';

import 'package:bug_mobile_controller/bug/user.dart';

class JsonUserDecoder {
  static User decode(String jsonString) {
    Map<String, dynamic> decodedUser = jsonDecode(jsonString);
    User user = new User(decodedUser['user_dongle_id'], decodedUser['name']);
    return user;
  }
}