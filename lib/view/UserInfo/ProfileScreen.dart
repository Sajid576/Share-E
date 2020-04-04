import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/HomeScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/UserInfo/EditProfile.dart';
class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var _profile_username;
  var _profile_phone_no;

  // activity jokon first initiate hoy tokhon initstate call hoy and runs only once the activity created
  void initState(){

    SharedPreferenceHelper.readfromlocalstorage().then((user) {

     //_profile_username = user.getusername();
      //in setstate it runs the activity and see if there is any change in the activity or not
      //because in the edit section data can be edited so we need setstate
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
      backgroundColor: Colors.tealAccent[700],
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                ),
              ),

              Text('Your profile',style: TextStyle(
                fontSize: 20,
                //fontFamily: 'SourceSansPro',
                color: Colors.black,
                letterSpacing: 2.5,
              ),),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Text('Welcome',style: TextStyle(
                fontSize: 20,
                //fontFamily: 'SourceSansPro',
                color: Colors.black,
                letterSpacing: 2.5,
              ),),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Card(
                  color: Colors.white,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      "$_profile_username",
                      style:
                      TextStyle( fontSize: 20.0),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      "$_profile_phone_no",
                      style:
                      TextStyle( fontSize: 20.0),
                    ),
                  )),
            ],

          ),
             ),
      ),


    );

  }
}