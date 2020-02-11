import 'package:share_e/screens/HomeScreen.dart';
import 'package:share_e/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import  'package:firebase_auth/firebase_auth.dart';
import 'package:share_e/services/SharedPreferenceHelper.dart';
import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';
void main() {

  //WidgetsFlutterBinding.ensureInitialized();
/*
  SharedPreferenceHelper.readfromlocalstorage().then((user)
  {
    print('signedup?? '+user.getsession().toString());

    _MyAppState.isSignedUp=  user.getsession();
    runApp(MyApp());

  });*/

  //runApp(HomeScreen());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static bool isSignedUp=false;

  @override
  Widget build(BuildContext context) {
    print('build hoise');
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),


        home: isSignedUp ==true ? HomeScreen() : LoginScreen(),


    );
  }
}



