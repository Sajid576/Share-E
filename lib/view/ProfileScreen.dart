import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';
import 'package:share_e/view/HomeScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/EditProfile.dart';
class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var _profile_username;
  var _profile_phone_no;

  // activity jokon first initiate hoy tokhon initstate call hoy
  void initState(){

    SharedPreferenceHelper.readfromlocalstorage().then((user) {

     //_profile_username = user.getusername();
     setState(() {
       _profile_phone_no=user.getphone();
       _profile_username = user.getusername();
       print("edit er uname"+_profile_username);
     });


    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle:true,
          backgroundColor: Colors.blueGrey[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings,color: Colors.white,),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Editprofile(

                        )));
              },
            )
          ],
        ),
      body:
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                    ),
                  ),

                  Text("$_profile_username"),
                  Text("$_profile_phone_no"),
                ],

              ),


            ],
          ),


    );

  }
}