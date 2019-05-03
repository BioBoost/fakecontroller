import 'dart:async';
import 'package:bug_mobile_controller/bug/simple_mqtt_client.dart';
import 'package:bug_mobile_controller/settings/mqtt_settings_storage.dart';

class MqttSimpleClientBuilder {
  static Future<SimpleMqttClient> create() {
    // Load MQTT settings
    return MqttSettingsStorage.load()
    .then((settings) {
      print("Settings loaded succesfully: " + settings.toString());
      // settings.broker = "api.bug.labict.be/broker";
      // settings.useWebSockets = true;
      return new SimpleMqttClient(settings);
    })
    .catchError((onError) {
      print("Failed to load settings. Reverting to default");
      return null;
    });
  }
}