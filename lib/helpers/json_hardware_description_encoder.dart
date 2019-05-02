import 'package:bug_mobile_controller/bug/addon.dart';
import 'dart:convert';

class JsonHardwareDescriptionEncoder {

  static String encode(String userDongleId, List<Addon> addons, String deviceId) {
    return jsonEncode({
      'id': userDongleId,
      'add_1': (addons[0]?.id ?? ''),
      'add_2': (addons[1]?.id ?? ''),
      'add_3': (addons[2]?.id ?? ''),
      'dev_id': deviceId
    });
  }
  
}