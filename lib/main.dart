import 'dart:core';
import 'package:bug_mobile_controller/screens/config_screen.dart';
import 'package:flutter/material.dart';
import 'screens/controller_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  runApp(MaterialApp(
    title: 'BUG Mobile Game Controller',
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => LoadingScreen(),
      '/login': (context) => LoginScreen(),
      '/': (context) => ControllerScreen(),
      '/config': (context) => ConfigScreen()
    }
  ));
}