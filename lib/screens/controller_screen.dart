import 'dart:async';
import 'dart:core';
import 'package:bug_mobile_controller/bug/addon.dart';
import 'package:bug_mobile_controller/bug/addon_loader.dart';
import 'package:bug_mobile_controller/bug/simple_mqtt_client.dart';
import 'package:bug_mobile_controller/bug/user.dart';
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

  PageController _pageController;
  int groupValue;
  double opacityValue = 0;
  String displayedString = "";
  String displayedString2 = "";
  String displayedStringOld = "";
  static const String pubTopic = 'ttn';
  static const String pubHardwareTopic = 'hardware';

  Timer timer;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    timer?.cancel();
    super.dispose();
  }

  String action = "idle";
  final String actionIdle = "idle";
  String movement = "idle";
  final String movementIdle = "idle";

  bool leftButtonState = false;
  bool rightButtonState = false;
  bool upButtonState = false;
  bool downButtonState = false;
  bool selectButtonState = false;
  bool startButtonState = false;
  bool YButtonState = false;
  bool AButtonState = false;
  bool XButtonState = false;
  bool BButtonState = false;
  bool startApp = true;

  Color leftButtonStateC =  Colors.red;
  Color rightButtonStateC =  Colors.red;
  Color upButtonStateC =  Colors.red;
  Color downButtonStateC = Colors.red;
  Color selectButtonStateC =  Colors.red;
  Color startButtonStateC =  Colors.red;
  Color YButtonStateC =  Colors.red;
  Color AButtonStateC =  Colors.red;
  Color XButtonStateC =  Colors.red;
  Color BButtonStateC = Colors.red;

  void createJsonSendMqttButton() {
    if (_client != null && _client.isConnected()) {
      displayedString = '{"movement":"' +
          movement +
          '","action":"' +
          action +
          '","dev_id":"' +
          _user.getName() +
          '"}';
      if (displayedString != displayedStringOld) {
        displayedStringOld = displayedString;
        _client.publish(pubTopic, displayedString);
      }
      if (startApp) {
        startApp = false;
        createJsonSendMqttStart();
      }
    }
  }

  String idHardware = "0080d0803b102f01";

  void createJsonSendMqttStart() {
    if (_client != null && _client.isConnected()) {
      displayedString2 = '{"id":"' +
          idHardware +
          '","add_1":"' +
          (_selectedAddons[0]?.id ?? '') +
          '","add_2":"' +
          (_selectedAddons[1]?.id ?? '') +
          '","add_3":"' +
          (_selectedAddons[2]?.id ?? '') +
          '","dev_id":"' +
          _user.getName() +
          '"}';
      _client.publish(pubHardwareTopic, displayedString2);
    }
  }

  void onPressedLeft() {
    setState(() {
      movement = "left";
    });
  }

  void onPressedUp() {
    setState(() {
      movement = "forward";
    });
  }

  void onPressedDown() {
    setState(() {
      movement = "backward";
    });
  }

  void onPressedRight() {
    setState(() {
      movement = "right";
    });
  }

  void actionSelect() {
    setState(() {
      action = "Select";
    });
  }

  void actionStart() {
    setState(() {
      action = "start";
    });
  }

  void actionY() {
    setState(() {
      action = "Y";
    });
  }

  void actionX() {
    setState(() {
      action = "X";
    });
  }

  void actionB() {
    setState(() {
      action = "B";
    });
  }

  void ActionA() {
    setState(() {
      action = "A";
    });
  }

  String messageFromMqtt = '{}';
  Map<String, dynamic> jsonMQTT;

  int _page = 0;

  List<Addon> _selectedAddons = new List<Addon>(3);

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
                ControllerSide(null, null, null, null, "assets/image/left_side.png"),

                ControllerMid("assets/image/mid.png"),

                // This is the right part of the controller,
                // which takes 3/8 parts of the screen width
                ControllerSide(null, null, null, null, "assets/image/right_side.png"),

              ],
            ))

          ]
        )
      )
    );
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 3), (Timer t) => createJsonSendMqttButton());
  }
}
