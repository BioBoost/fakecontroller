import 'dart:core';
import 'package:bug_mobile_controller/mqtt_settings.dart';
import 'package:bug_mobile_controller/screens/helpers/preference_title.dart';
import 'package:bug_mobile_controller/settings/mqtt_settings_storage.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {

  @override
  _ConfigScreenState createState() => new _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final brokerUrlController = TextEditingController(text: '');
  final brokerPortController = TextEditingController(text: '');

  MqttSettings _mqttSettings = MqttSettings();
  String _brokerUrl;
  String _brokerPort;
  bool _useWebSockets;

  final key = new GlobalKey<ScaffoldState>();   // Required for Toast (Snackbar Messages)

  @override
  void initState() {
    // Load Settings
    MqttSettingsStorage.load()
    .then((settings) {
      print("Settings loaded succesfully: " + settings.toString());
      setState(() {
        _mqttSettings = settings;
        _brokerUrl = _mqttSettings.broker;
        _brokerPort = _mqttSettings.port.toString();
        _useWebSockets = _mqttSettings.useWebSockets;
        brokerUrlController.text = _brokerUrl;
        brokerPortController.text = _brokerPort;
      });
    })
    .catchError((onError) {
      print("Failed to load settings. Reverting to default");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PreferenceTitle("MQTT Broker Settings"),
                ListTile(
                  leading: Text("Broker URL"),
                  title: TextField(
                    controller: brokerUrlController,
                    decoration: InputDecoration(
                      hintText: "mqtt.labict.be",
                    )
                  ),
                ),
                ListTile(
                  leading: Text("Broker port"),
                  title: TextField(
                    controller: brokerPortController,
                    decoration: InputDecoration(
                      hintText: "1883",
                    )
                  ),
                ),
                SwitchListTile(
                  title: const Text('Use Websockets?'),
                  value: _mqttSettings.useWebSockets,
                  onChanged: (bool value) {
                    setState(() {
                      _useWebSockets = value;
                    });
                  },
                ),
                SizedBox(height: 35),
                RaisedButton(
                  child: Text('Save'),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: () {
                    if (brokerUrlController.text?.isNotEmpty
                      && brokerPortController.text?.isNotEmpty) {
                        print("Saving MQTT settings ...");
                        _mqttSettings.broker = brokerUrlController.text;
                        _mqttSettings.port = int.parse(brokerPortController.text);
                        _mqttSettings.useWebSockets = _useWebSockets;

                        MqttSettingsStorage.save(_mqttSettings).then((x) =>
                          { Navigator.pushNamed(context, '/loading') })
                          .catchError((onError) {
                            print("Failed to save MQTT settings.");
                            key.currentState.showSnackBar(new SnackBar(
                              content: const Text("Failed to save MQTT settings")
                            ));
                          });

                    } else {
                      key.currentState.showSnackBar(new SnackBar(
                        content: const Text("Please enter a host and port")
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
    super.dispose();
  }
}