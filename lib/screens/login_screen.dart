import 'dart:core';
import 'package:bug_mobile_controller/bug/mqtt_builder.dart';
import 'package:flutter/material.dart';
import '../bug/user.dart';
import '../settings/user_settings_storage.dart';
import '../mqtt_settings.dart';
import '../bug/simple_mqtt_client.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userIdController = TextEditingController(text: '');
  final userNameController = TextEditingController(text: '');

  final key = new GlobalKey<ScaffoldState>();   // Required for Toast (Snackbar Messages)

  User _user = new User("", "");
  MqttSettings mqttSettings = MqttSettings();
  SimpleMqttClient client;

  @override
  void initState() {
    // Load User settings
    UserSettingsStorage.load()
    .then((user) {
      print("User: " + user.toString());
      setState(() {
        _user = user;
      });
    })
    .catchError((onError) {
      print("Failed to load User.");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userIdController.text = _user.getId();
    userNameController.text = _user.getName();

    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 45),
                  child: Text(
                    'Please supply your User ID and Name below or scan the QR code from your profile on the Kiosk.',
                    style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.4,
                  ),
                ),
                SizedBox(height: 35),
                RaisedButton(
                  child: Text('Scan QR Code'),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () {
                    print("User pressed QR code button");
                  },
                ),
                SizedBox(height: 35),
                ListTile(
                  leading: const Icon(Icons.videogame_asset),
                  title: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      hintText: "User ID ...",
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.face),
                  title: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: "Name ...",
                    ),
                  ),
                ),
                SizedBox(height: 35),
                RaisedButton(
                  child: Text('Continue'),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () {
                    if (userNameController.text?.isNotEmpty
                      && userIdController.text?.isNotEmpty) {
                        print("Saving user and logging in ...");
                        User user = new User(userIdController.text, userNameController.text);
                        UserSettingsStorage.save(user)
                        .catchError((onError) {
                          print("Failed to save User.");
                        });

                        // Create MQTT Client
                        MqttSimpleClientBuilder.create()
                        .then((client) {
                          Navigator.pushNamed(context, '/', arguments: {
                            client: client,
                            user: user
                          });
                        })
                        .catchError((onError) {
                          print("Failed to connect to MQTT");
                          key.currentState.showSnackBar(new SnackBar(
                            content: const Text("Failed to connect to MQTT")
                          ));
                        });
                        
                    } else {
                      key.currentState.showSnackBar(new SnackBar(
                        content: const Text("Please enter ID and Name")
                      ));
                    }
                  },
                ),
              ],
            )
          )
        )
      )
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the Widget is disposed
    userIdController.dispose();
    userNameController.dispose();
    super.dispose();
  }
}