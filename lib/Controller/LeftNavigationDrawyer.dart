

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/Authentication/LoginScreen.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
import 'package:share_e/view/UserInfo/ProfileScreen.dart';
import 'package:share_e/view/UserRecord/YourCartList.dart';
import 'package:share_e/view/UserRecord/YourReceivedService.dart';
import 'package:share_e/view/UserRecord/YourSharedService.dart';
import 'package:share_e/view/UserRecord/ShareYourServices.dart';


class LeftNavDrawyer  {
  static Duration duration = const Duration(milliseconds: 300);
  AnimationController controller;
  bool isCollapsed = true; //at the begining it is collapsed that means only home is showing 100%
  Animation<double> scaleAnimation;

  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Color selectedBackgroundColor =Colors.white;
  // _controller,_scaleAnimation these for top and bottom so that they don't have overflow condition
  static bool leftEnabled=false;

  LeftNavDrawyer(control){

      //these code for homePage layout animation
      this.controller=control;
      scaleAnimation=Tween<double>(begin: 1,end: 0.6).animate(controller);
      //these tow for menu animation
      _menuScaleAnimation = Tween<double>(begin: 0.5,end: 1).animate(controller);
      _slideAnimation = Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0)).animate(controller);

  }


Widget leftNavLayout(BuildContext context) {
  return SlideTransition(
    position: _slideAnimation,
    child: ScaleTransition(
      scale: _menuScaleAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                FlatButton(
                  disabledColor: selectedBackgroundColor,
                  child:Text(
                    "Home",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ));
                  },

                ),

                SizedBox(
                  height: 18,
                ),
                FlatButton(
                  disabledColor: selectedBackgroundColor,
                  child:Text(
                    "Profile",
                    style: TextStyle(color:  Colors.black, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ProfileScreen(),
                        ));
                  },

                ),

                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Share Service",
                      style: TextStyle(color:  Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ShareYourServices(),
                          ));
                    }
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Your Shared Service",
                      style: TextStyle(color:  Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => YourSharedService(),
                          ));
                    }
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Your Received Service",
                      style: TextStyle(color:  Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => YourReceivedService(),
                          ));
                    }
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Your Cart Services",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => YourCartList(),
                          ));
                    }
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Your Requisite Services",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Messages",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                     


                    }
                ),


                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "All Requisite Services",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
                SizedBox(
                  height: 18,
                ),
                FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Account",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
                SizedBox(
                  height: 18,
                ),

                FlatButton(
                  disabledColor: selectedBackgroundColor,
                  child:Text(
                    "Logout",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onPressed: () {
                    //this logout() used for erasing the session
                    SharedPreferenceHelper.logout();

                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ));
                  },
                ),

                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}




}