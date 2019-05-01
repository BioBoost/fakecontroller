import 'dart:core';
import 'package:bug_mobile_controller/bug/simple_mqtt_client.dart';
import 'package:flutter/material.dart';

class ControllerScreen extends StatefulWidget {
  @override
  _ControllerScreenState createState() => new _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  SimpleMqttClient _client;

  @override
  Widget build(BuildContext context) {
    final SimpleMqttClient mqttClient = ModalRoute.of(context).settings.arguments;
    if (mqttClient != null) {
      _client = mqttClient;
      print("Received MQTT client reference in Controller");
    }
    return Scaffold(
    );
  }

}