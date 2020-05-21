import 'package:flutter/material.dart';

import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/UserInfo/EditProfile.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle:true,
          backgroundColor: Colors.black,
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
                    title:null ,
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
                      null,
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