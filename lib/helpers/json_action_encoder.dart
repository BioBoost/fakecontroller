import 'dart:convert';

class JsonActionEncoder {

  static String encode(String deviceId, String action, String movement) {
    return jsonEncode({
      'movement': movement,
      'action': action,
      'dev_id': deviceId
    });
  }
  
}