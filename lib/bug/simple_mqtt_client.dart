import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import '../mqtt_settings.dart';

class SimpleMqttClient {

  mqtt.MqttClient _client = null;
  MqttSettings _settings = null;

  SimpleMqttClient(MqttSettings settings) {
    _settings = settings;
    _connect();
  }

  void publish(String topic, String message) {
    if (isConnected()) {
      mqtt.MqttClientPayloadBuilder builder = mqtt.MqttClientPayloadBuilder();
      builder.addString(message);
      _client?.publishMessage(topic, mqtt.MqttQos.exactlyOnce, builder.payload);
    } else {
      print("Not connected to broker");
    }
  }

  bool isConnected() {
    if (_client == null) {
      return false;
    }
    return (_client?.connectionState == mqtt.MqttConnectionState.connected);
  }

  void disconnect() {
    print("Disconnecting from broker");
    _client?.disconnect();
    _onDisconnected();
  }

  void _connect() async {
    _client = mqtt.MqttClient(_settings.getBrokerUrl(), '');
    _client.useWebSocket = _settings.useWebSockets;
    _client.port = _settings.port;
    _client.logging(on: true);

    _client.keepAlivePeriod = 60;

    // Add the unsolicited disconnection callback
    _client.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connectionMessage = mqtt.MqttConnectMessage()
        .withClientIdentifier(_settings.clientId)
        // Must agree with the keep alive set above or not set
        .startClean() // Non persistent session for testing
        .keepAliveFor(_client.keepAlivePeriod);
    
    print('MQTT client connecting ...');
    _client.connectionMessage = connectionMessage;

    // Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    // in some circumstances the broker will just disconnect us, see the spec about this, we however will
    // never send malformed messages.
    try {
      await _client.connect();
    } catch (e) {
      print("Connection to broker failed");
      disconnect();
    }

    if (isConnected()) {
      print("Succesfully connected to broker");
    } else {
      print("Not connected to broker");
      disconnect();    // Cleanup
    }
  }

  void _onDisconnected() {
    _client = null;
    print('MQTT client disconnected');
  }
}