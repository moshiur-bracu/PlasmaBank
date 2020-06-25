import 'dart:async';
import 'dart:io';

import 'package:PlasmaBank/screens/Donor/Home/donor_home_requests.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _message = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }
  
  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() => _message = message["notification"]["title"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      //setState(() => _message = message["notification"]["title"]);
        
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      //setState(() => _message = message["notification"]["title"]);
    });
  }

  

  

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlasmaBank',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme
        ),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper(),
    );
  }
}