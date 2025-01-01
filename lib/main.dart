import 'package:flutter/material.dart';
import 'package:tutorialapp/pages/home.dart';
import 'package:tutorialapp/pages/choose_location.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/location':(context) =>ChooseLocation(),

    },
  ));
}


