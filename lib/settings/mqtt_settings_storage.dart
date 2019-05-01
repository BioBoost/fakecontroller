import 'dart:async';
import '../mqtt_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MqttSettingsStorage {

  static Future<MqttSettings> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String broker = (prefs.getString('mqtt_broker') ?? null);
    String clientId = (prefs.getString('mqtt_client_id') ?? null);
    int port = (prefs.getInt('mqtt_port') ?? -1);
    bool useWebSockets = (prefs.getBool('mqtt_use_web_sockets') ?? false);

    MqttSettings settings = new MqttSettings();
    if (broker != null && clientId != null) {
      print("Loaded MQTT settings");
      settings.broker = broker;
      settings.clientId = clientId;
      settings.port = port;
      settings.useWebSockets = useWebSockets;
    } // else returning defaults in class

    return settings;
  }

  static Future<void> save(MqttSettings settings) async {
    print("Saving MQTT settings");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mqtt_broker', settings.broker);
    await prefs.setString('mqtt_client_id', settings.clientId);
    await prefs.setInt('mqtt_port', settings.port);
    await prefs.setBool('mqtt_use_web_sockets', settings.useWebSockets);
  }
}