import 'dart:async';
import 'package:share_e/main.dart';
import 'package:flutter/material.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/Authentication/LoginScreen.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  BuildContext context;

  static bool _isSignedUp=false;

  @override
  void initState() {
    super.initState();


    Timer(Duration(
      milliseconds: 2000,
    ), () {

      SharedPreferenceHelper.readfromlocalstorage().then((user)
      {

        print('signedup?? '+user.getsession().toString());

        bool isSignedUp=  user.getsession();

        setState(() {
          _isSignedUp=isSignedUp;
        });


        Navigator.pop(context);

        if(_isSignedUp){
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen() )) ;
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen() )) ;
        }




      });


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

  void autoLogin() async {



  }



}