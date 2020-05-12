import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_e/main.dart';
import 'package:flutter/material.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
import 'package:share_e/view/Authentication/signin_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  BuildContext context;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();

    Timer(Duration(
      milliseconds: 2000,
    ), () {
      Navigator.pop(context);
      if(user != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen() )) ;
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (_) => SignInPage() )) ;
      }


    }
    );
  }


  @override
  Widget build(BuildContext context) {
    this.context=context;

    return new Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: new Image(
                image: new AssetImage('assets/splash.png')),
          ),
        ],
      ),
    );
  }


}