import 'package:flutter/material.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:share_e/view/UserRecord/ShareYourServices.dart';
import 'package:share_e/view/UserInfo/ProfileView.dart';
import 'package:share_e/view/GoogleMap/ServiceMarkerIcon.dart';


void main()  {

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static bool _isSignedUp=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //autoLogin();

  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: HomeScreen(),

         // home: _isSignedUp ==true ? HomeScreen() : LoginScreen(),




    );
  }


  void autoLogin() async {

    SharedPreferenceHelper.readfromlocalstorage().then((user)
    {

      print('signedup?? '+user.getsession().toString());

      bool isSignedUp=  user.getsession();

      setState(() {
        _isSignedUp=isSignedUp;
      });
    });

  }
}








