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
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

class ControllerScreen extends StatefulWidget {
  @override
  _ControllerScreenState createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  SimpleMqttClient _client;
  User _user;
  String devId;

  List<Addon> _addons = AddonLoader.load();

  static const String mqttActionTopic = 'ttn';
  static const String mqttHardwareTopic = 'hardware';

  String _action = "idle";
  String _movement = "idle";
  String _actionFeedback = '';
  String _movementFeedback = '';
  String _feedback = 'Select addons and press start';
  int _countdown = 0;

  bool started = false;
  Timer actionTimer;
  int timeBeforeSend = 4;

  List<Addon> _selectedAddons = new List<Addon>(3);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    actionTimer?.cancel();
    super.dispose();
  }

  void publishActions() {
    String json = JsonActionEncoder.encode(devId, _action, _movement);
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
    if (args?.user != null) { 
      _user = args.user;
      devId = md5.convert(utf8.encode(_user.getName()+_user.getId())).toString().substring(0, 25);
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        // Stack for placing feedback on top
        child: Stack(children: <Widget>[
          Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AddonDropdown(_addons, (selected) {
                    _selectedAddons[0] = selected;
                  }),
                  AddonDropdown(_addons, (selected) {
                    _selectedAddons[1] = selected;
                  }),
                  AddonDropdown(_addons, (selected) {
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
                    onTopPressed: () => { move("forward") },
                    onBottomPressed: () => { move("backward") },
                    onLeftPressed: () => { move("left") },
                    onRightPressed: () => { move("right") },
                    imageAssetKey: "assets/image/left_side.png"),

                  // Mid part with select and start buttons
                  ControllerMid("assets/image/mid.png", clearActions, start),

                  // This is the right part of the controller,
                  // which takes 3/8 parts of the screen width
                  ControllerSide(
                    onTopPressed: () => { act("X") },
                    onBottomPressed: () => { act("B") },
                    onLeftPressed: () => { act("Y") },
                    onRightPressed: () => { act("A") },
                    imageAssetKey: "assets/image/right_side.png",
                    useLetters: true),

                ],
              )),

            ]
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              Expanded(
                flex: 8,
                child: Row(children: <Widget>[])
              ),

              Expanded(
                flex: 1,
                child: Container(
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: ((_countdown <= 0) ? Colors.grey : Colors.greenAccent),
                  ),
                  child: Center(child: Text((_countdown <= 0 ? '' : _countdown.toString()),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                  ))),
                  width: 64,
                )
              ),

              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    // Movement
                    Container(
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: (_movementFeedback == '' ? Colors.grey : Colors.greenAccent),
                      ),
                      child: Center(child: Text(_movementFeedback)),
                      width: 64,
                    ),

                    Align(
                      alignment: FractionalOffset(0, 1),
                      child: Text(_feedback)
                    ),

                    // Action
                    Container(
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: (_actionFeedback == '' ? Colors.grey : Colors.greenAccent),
                      ),
                      child: Center(child: Text(_actionFeedback)),
                      width: 64,
                    )
                  ]
                )
              )

            ])
        ])
      )
    );
  }

  bool checkMqtt() {
    if (_client == null || !_client.isConnected()) {
      setState(() {
        _feedback = "Not connected to MQTT. Please check settings.";
      });
      new Timer(Duration(seconds: 2), () => {
        Navigator.pushNamed(context, '/config')
      });
      return false;
    }
    return true;
  }

  void start() {
    if (!checkMqtt()) {
      return;
    }
    publishInitialHardwareDescription();
    setState(() {
      _feedback = 'Ready! Press buttons to move and act';
      started = true;
    });
  }

  void setupTimer() {
    if (actionTimer == null) {
      setState(() {
        _countdown = timeBeforeSend;
      });
      actionTimer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
        setState(() {
          _countdown--;
        });
        if (_countdown <= 0) {
          publishActions();
          clearActions();
        }
      });
    }
  }

  void move(String direction) {
    setupTimer();
    if (started) {
        setState(() {
        _movement = direction;
        _movementFeedback = direction.substring(0, 1).toUpperCase();
      });
    }
  }

  void act(String action) {
    setupTimer();
    if (started) {
      setState(() {
        _action = action;
        _actionFeedback = action; 
      });
    }
  }

  void clearActions() {
    actionTimer?.cancel();
    actionTimer = null;
    setState(() {
      _movement = 'idle';
      _movementFeedback = '';
      _action = 'idle';
      _actionFeedback = '';
      _countdown = 0;
    });
  }
}