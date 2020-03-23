import 'package:share_e/view/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:share_e/view/ListViewServiceShare.dart';
import 'package:share_e/view/LoginScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/ProfileScreen.dart';
import 'package:share_e/view/YourSharedService.dart';

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
    autoLogin();

  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Scaffold(
         // body: _isSignedUp ==true ? HomeScreen() : LoginScreen(),
        body:YourSharedService(),
      ),



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








