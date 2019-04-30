import 'dart:math';

class MqttSettings {
  String broker = "api.bug.labict.be/broker";
  String clientId = "quest_";
  int port = 443;
  bool useWebSockets = true;
    // A websocket URL must start with ws:// or wss:// or Dart will throw an exception

  MqttSettings() {
    clientId = "guest_" + (new Random()).nextInt(10000).toString();
  }

  String getBrokerUrl() {
    if (useWebSockets) {
      return "wss://" + broker;
    } else {
      return broker;
    }
  }
}