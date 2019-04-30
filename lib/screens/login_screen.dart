import 'dart:core';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userIdController = TextEditingController(text: '');
  final userNameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
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
                  print("User is logging in");
                },
              ),
            ],
          )
        )
      )
    );
  }
}