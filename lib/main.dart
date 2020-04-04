import 'dart:async';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/Authentication/LoginScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/UserInfo/ProfileScreen.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/UserInfo/ProfileView.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/UserRecord/YourCartList.dart';

void main() {
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

      home: YourCartList(),
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








