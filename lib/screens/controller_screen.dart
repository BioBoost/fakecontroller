import 'dart:async';
import 'dart:core';
import 'package:bug_mobile_controller/bug/simple_mqtt_client.dart';
import 'package:bug_mobile_controller/mqtt_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SimpleMqttClient _client;

  PageController _pageController;
  int groupValue;
  double opacityValue = 0;
  String displayedString = "";
  String displayedString2 = "";
  String displayedStringOld = "";
  static const String pubTopic = 'ttn';
  static const String pubHardwareTopic = 'hardware';
  //builder.addString('Hello from mqtt_client');
  IconData connectionStateIcon;

  Timer timer;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    timer?.cancel();
    brokerAddressController.dispose();
    usernameController.dispose();
    //passwordController.dispose();
    super.dispose();
  }

  String action = "idle";
  final String actionIdle = "idle";
  String movement = "idle";
  final String movementIdle = "idle";
  String username = "gio_anil";

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

  //Color selection = Colors.green[400];


  void createJsonSendMqttButton() {
    if (_client != null && _client.isConnected()) {
      displayedString = '{"movement":"' +
          movement +
          '","action":"' +
          action +
          '","dev_id":"' +
          username +
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

  String dropdownAddOnValue1 = "Add on";
  String dropdownAddOnValue2 = "Add on";
  String dropdownAddOnValue3 = "Add on";
  String rocketEngineAdd = "01a2f560d6df03bb";
  String amphibiousAdd = "0140c29c8357f2ce"; //-> 0140c29c8357f2ce
  String harrierAdd = "0155cf8199f0245b"; //-> 0155cf8199f0245b
  String adamantiumAdd = "016bc4464286f3fb"; //-> 016bc4464286f3fb
  String gravyShieldAdd = "0148eef363dff533"; //-> 0148eef363dff533
  String nanobotsAdd = "0164a54798d7d27a"; //-> 0164a54798d7d27a
  String structuralStrengtheningAdd = "0136edcaaf285d1d"; //-> 0136edcaaf285d1d
  String FlammenwerpferAdd = "011d5ba90ce241e6"; //-> 011d5ba90ce241e6
  String laserAdd = "01a2eb344edc7c5a"; //-> 01a2eb344edc7c5a
  String minesAdd = "01d9643e2bf10134"; //-> 01d9643e2bf10134
  String plasmaGunAdd = "0100548e2b3038f5"; //-> 0100548e2b3038f5
  String empBombAdd = "01ff7ab8c2155e57"; //-> 01ff7ab8c2155e57
  String ramAdd = "0122e76e424f7c79"; //-> 0122e76e424f7c79
  String gatlingGunAdd = "01f94b5e5d4277b5"; //-> 01f94b5e5d4277b5

  String idHardware = "0080d0803b102f01";
  String add_1 = "0";
  String add_2 = "0";
  String add_3 = "0";

  void addHascodeAddons(String dropdownAddOnValue, int addOnSelection) {
    String addOnSelectionToJsonTemp = "";
    switch (dropdownAddOnValue) {
      case "rocketEngine":
        {
          addOnSelectionToJsonTemp = rocketEngineAdd;
        }
        break;
      case "amphibious":
        {
          addOnSelectionToJsonTemp = amphibiousAdd;
        }
        break;
      case "harrier":
        {
          addOnSelectionToJsonTemp = harrierAdd;
        }
        break;
      case "adamantium":
        {
          addOnSelectionToJsonTemp = adamantiumAdd;
        }
        break;
      case "gravyShield":
        {
          addOnSelectionToJsonTemp = gravyShieldAdd;
        }
        break;
      case "nanobots":
        {
          addOnSelectionToJsonTemp = nanobotsAdd;
        }
        break;
      case "structuralStrengthening":
        {
          addOnSelectionToJsonTemp = structuralStrengtheningAdd;
        }
        break;
      case "Flammenwerpfer":
        {
          addOnSelectionToJsonTemp = FlammenwerpferAdd;
        }
        break;
      case "laser":
        {
          addOnSelectionToJsonTemp = laserAdd;
        }
        break;
      case "mines":
        {
          addOnSelectionToJsonTemp = minesAdd;
        }
        break;
      case "plasmaGun":
        {
          addOnSelectionToJsonTemp = plasmaGunAdd;
        }
        break;
      case "empBomb":
        {
          addOnSelectionToJsonTemp = empBombAdd;
        }
        break;
      case "ram":
        {
          addOnSelectionToJsonTemp = ramAdd;
        }
        break;
      case "gatling gun":
        {
          addOnSelectionToJsonTemp = gatlingGunAdd;
        }
        break;
      default:
        {
          addOnSelectionToJsonTemp = "invalid";
        }
        break;
    }
    switch (addOnSelection) {
      case 1:
        {
          add_1 = addOnSelectionToJsonTemp;
        }
        break;

      case 2:
        {
          add_2 = addOnSelectionToJsonTemp;
        }
        break;

      case 3:
        {
          add_3 = addOnSelectionToJsonTemp;
        }
        break;

      default:
        {
          add_1 = "invalidchose";
        }
        break;
    }
  }

  void createJsonSendMqttStart() {
    if (_client != null && _client.isConnected()) {
      displayedString2 = '{"id":"' +
          idHardware +
          '","add_1":"' +
          add_1 +
          '","add_2":"' +
          add_2 +
          '","add_3":"' +
          add_3 +
          '","dev_id":"' +
          username +
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

  final brokerAddressController =
      TextEditingController(text: '0080d0803b102f01');
  final usernameController = TextEditingController(text: 'Tester');
  //final passwordController = TextEditingController();


  String messageFromMqtt = '{}';
  //Map jsonMap = JSON.decode(messageFromMqtt);
  //Map<String, dynamic> user = jsonDecode(messageFromMqtt);
  //dynamic convert(String input) => _parseJson(input, _reviver);

  Map<String, dynamic> jsonMQTT;

  int _page = 0;

  void addValuesToMqttClient() {
    idHardware = brokerAddressController.text;
    username = usernameController.text;
    //password = passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    if (_client != null && _client.isConnected()) {
      connectionStateIcon = Icons.cloud_done;
    } else {
      connectionStateIcon = Icons.cloud_off;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        ///resizeToAvoidBottomPadding: false,
        ///
        //
        /*
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.build), title: Text('Add broker')),
            BottomNavigationBarItem(
                icon: Icon(Icons.gamepad), title: Text('BUG Controller')),
          ],
          currentIndex: _page,
          fixedColor: Colors.blue,
          onTap: navigationTapped,
        ),
        */
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            _buildAddBrokerPage(),
            _buildFakecontrollerPage(),
          ],
        ),
      ),
    );
  }

  Column _buildAddBrokerPage() {
    final _formKey = GlobalKey<FormState>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30),
          child: ListTile(
            leading: const Icon(Icons.location_city),
            title: TextField(
              controller: brokerAddressController,
              decoration: InputDecoration(
                hintText: "id",
              ),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.more_horiz),
          title: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: "username",
            ),
            //keyboardType: TextInputType.number,
          ),
        ),
        /*
        ListTile(
          leading: const Icon(Icons.more_vert),
          title: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "password",
            ),
            //keyboardType: TextInputType.number,
          ),
        ),
        */
        Row(
          children: <Widget>[
            RaisedButton(
              child: Text(
                  (_client != null && _client.isConnected())
                      ? 'Disconnect'
                      : 'Connect'),
              textColor: Colors.white,
              color: Colors.redAccent,
              onPressed: () {
                addValuesToMqttClient();
                if (_client != null && _client.isConnected()) {
                  startApp = true;
                  _client?.disconnect();
                } else {
                  _client = new SimpleMqttClient(new MqttSettings());
                }
              },
            ), SizedBox(
              width: 8.0,
            ),
            Icon(connectionStateIcon),
            SizedBox(height: 8.0),
            SizedBox(width: 8.0),
          ],
        ),
      ],
    );
  }

  Container _buildFakecontrollerPage() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/image/bug-logo-z.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomLeft),
            ),
          ),
         //SingleChildScrollView(
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                //1e colom
                Column(
                  //mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    addOnController1(1, 0, 0, 0, 90),
                    buttonControllerMove(
                      //left: left, right: right, top: top, bottom: bottom
                        Icons.arrow_left, onPressedLeft,leftButtonStateC, 75, 0, 0, 140),
                  ],
                ),
                //2e colom
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*
                      Flexible(
                        flex: 1,
                        child: Container(
                          width:
                              77.0, // 77 because othrise the t wil be on a nieuw line
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValueMovementDefault,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValueMovementDefault = newValue;
                              });
                            },
                            items: <String>[
                              dropdownValueMovementDefault,
                              'Rocket engine',
                              'Amphibious',
                              'Harrier'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.0,
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      */
                    buttonControllerMove(
                        Icons.arrow_drop_up, onPressedUp,upButtonStateC, 0, 0, 0, 50),
                    buttonControllerMove(
                        Icons.arrow_drop_down, onPressedDown,downButtonStateC, 0, 0, 0, 90),
                  ],
                ),
                //3e colom
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buttonControllerMove(
                        Icons.arrow_right, onPressedRight,rightButtonStateC, 0, 0, 0, 140),
                  ],
                ),

                //4e colom
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buttonControllerAction(
                        "Select", actionSelect, 40, 0, 0, 100),
                  ],
                ),

                //5e kolom
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buttonControllerAction(
                        "Start", actionStart, 20, 0, 0, 100),
                  ],
                ),
                //6e colom
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    addOnController2(2, 0, 0, 0, 90),
                    buttonControllerAction(
                        "Y", actionY, 35, 0, 0, 140),
                  ],
                ),
                //7ecolom
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buttonControllerAction(
                        "X", actionX, 0, 0, 0, 60),
                    buttonControllerAction(
                        "B", actionB, 0, 0, 0, 85),
                  ],
                ),
//8e colom
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    addOnController3(3, 0, 0, 0, 90),
                    buttonControllerAction(
                        "A", ActionA, 0, 20, 0, 140),
                  ],
                ),
              ],
            ),
          //),
        ],
      ),
    );
  }

  Widget buttonControllerMove(IconData button, method,Color color , double left,
      double right, double top, double bottom) {
    return Container(
      padding:
      EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: ButtonTheme(
        minWidth: 50.0,
        height: 50.0,
        child: RaisedButton(
            child: Icon(button), color: color, onPressed: method),
      ),
    );
  }

  Widget buttonControllerAction(String button, method, double left,
      double right, double top, double bottom) {
    return Container(
      padding:
      EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: ButtonTheme(
        minWidth: 50.0,
        height: 50.0,
        child: RaisedButton(
            child: Text(button), color: Colors.red, onPressed: method),
      ),
    );
  }

  Widget addOnController1(int addOnSelectionToJson, double left, double right,
      double top, double bottom) {
    return Container(
      width: 100,
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownAddOnValue1,
        onChanged: (String newValue) {
          setState(() {
            dropdownAddOnValue1 = newValue;
            addHascodeAddons(dropdownAddOnValue1, addOnSelectionToJson);
            createJsonSendMqttStart();
          });
        },
        items: <String>[
          //dropdownAddOnValue,
          "Add on",// need the same ontherwase crash
          "rocketEngine",
          "amphibious",
          "harrier",
          "adamantium",
          "gravyShield",
          "nanobots",
          "structuralStrengthening",
          "Flammenwerpfer",
          "laser",
          "mines",
          "plasmaGun",
          "empBomb",
          "ram",
          "gatling gun"
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                )),
          );
        }).toList(),
      ),
    );
  }

  Widget addOnController2(int addOnSelectionToJson, double left, double right,
      double top, double bottom) {
    return Container(
      width: 80,
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownAddOnValue2,
        onChanged: (String newValue) {
          setState(() {
            dropdownAddOnValue2 = newValue;
            addHascodeAddons(dropdownAddOnValue2, addOnSelectionToJson);
            createJsonSendMqttStart();
          });
        },
        items: <String>[
          //dropdownAddOnValue,
          "Add on",
          "rocketEngine",
          "amphibious",
          "harrier",
          "adamantium",
          "gravyShield",
          "nanobots",
          "structuralStrengthening",
          "Flammenwerpfer",
          "laser",
          "mines",
          "plasmaGun",
          "empBomb",
          "ram",
          "gatling gun"
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                )),
          );
        }).toList(),
      ),
    );
  }

  Widget addOnController3(int addOnSelectionToJson, double left, double right,
      double top, double bottom) {
    return Container(
      width: 80,
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownAddOnValue3,
        onChanged: (String newValue) {
          setState(() {
            dropdownAddOnValue3 = newValue;
            addHascodeAddons(dropdownAddOnValue3, addOnSelectionToJson);
            createJsonSendMqttStart();
          });
        },
        items: <String>[
          //dropdownAddOnValue,
          "Add on",
          "rocketEngine",
          "amphibious",
          "harrier",
          "adamantium",
          "gravyShield",
          "nanobots",
          "structuralStrengthening",
          "Flammenwerpfer",
          "laser",
          "mines",
          "plasmaGun",
          "empBomb",
          "ram",
          "gatling gun"
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                )),
          );
        }).toList(),
      ),
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
