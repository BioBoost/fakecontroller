import 'dart:async';
import 'dart:core';
import 'package:bug_mobile_controller/bug/addon.dart';
import 'package:bug_mobile_controller/bug/addon_loader.dart';
import 'package:bug_mobile_controller/bug/simple_mqtt_client.dart';
import 'package:bug_mobile_controller/bug/user.dart';
import 'package:bug_mobile_controller/helpers/json_action_encoder.dart';
import 'package:bug_mobile_controller/helpers/json_hardware_description_encoder.dart';
import 'package:bug_mobile_controller/screens/helpers/login_arguments.dart';
import 'package:bug_mobile_controller/widgets/controller_partials/addon_dropdown.dart';
import 'package:bug_mobile_controller/widgets/controller_partials/controller_mid.dart';
import 'package:bug_mobile_controller/widgets/controller_partials/controller_side.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SimpleMqttClient _client;
  User _user;

  List<Addon> _addons = AddonLoader.load();

  static const String mqttActionTopic = 'test/ttn';
  static const String mqttHardwareTopic = 'test/hardware';

  Timer timer;

  String action = "idle";
  String movement = "idle";

  bool startApp = true;

  String devId = "WhatToTakeAsDevId";
  List<Addon> _selectedAddons = new List<Addon>(3);

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    timer?.cancel();
    super.dispose();
  }

  void publishActions() {
    String json = JsonActionEncoder.encode(devId, action, movement);
    _client?.publish(mqttActionTopic, json);
  }

  void publishInitialHardwareDescription() {
    String json = JsonHardwareDescriptionEncoder.encode(_user.getId(), _selectedAddons, devId);
    _client.publish(mqttHardwareTopic, json);
  }

  @override
  Widget build(BuildContext context) {
    final LoginArguments args = ModalRoute.of(context).settings.arguments;
    if (args?.mqttClient != null) {  _client = args.mqttClient; }
    if (args?.user != null) {  _user = args.user; }
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AddonDropdown(_addons, (selected) {
                  print("Addon 1: " + selected.name);
                  _selectedAddons[0] = selected;
                }),
                AddonDropdown(_addons, (selected) {
                  print("Addon 2: " + selected.name);
                  _selectedAddons[1] = selected;
                }),
                AddonDropdown(_addons, (selected) {
                  print("Addon 3: " + selected.name);
                  _selectedAddons[2] = selected;
                }),
              ]
            ),

            Flexible(child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // This is the left part of the controller,
                // which takes 3/8 parts of the screen width
                ControllerSide(
                  () => { movement = "up" },
                  () => { movement = "backward" },
                  () => { movement = "left" },
                  () => { movement = "right" }, "assets/image/left_side.png"),

                // Mid part with select and start buttons
                ControllerMid("assets/image/mid.png", () => { print("Select")}, start),

                // This is the right part of the controller,
                // which takes 3/8 parts of the screen width
                ControllerSide(
                  () => { action = "X" },
                  () => { action = "B" },
                  () => { action = "Y" },
                  () => { action = "A" }, "assets/image/right_side.png"),

              ],
            )),

            Row(children: <Widget>[
              
            ],)

          ]
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(
    //     Duration(seconds: 3), (Timer t) => createJsonSendMqttButton());
  }

  void start() {
    publishInitialHardwareDescription();
  }
}
