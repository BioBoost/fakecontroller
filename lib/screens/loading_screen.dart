import 'dart:core';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../settings/user_settings_storage.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => new LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // Load User settings
    UserSettingsStorage.load()
    .then((user) {
      print("User: " + user.toString());
    })
    .catchError((onError) {
      print("Failed to load User.");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 6,
      navigateAfterSeconds: '/login',
      title: new Text('Welcome to the mobile BUG Game Controller',
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28.0
        ),
      ),
      image: Image.asset('assets/image/bug-logo.png'),
      backgroundColor: Colors.white,
      loadingText: new Text('An initiative by VIVES'),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}