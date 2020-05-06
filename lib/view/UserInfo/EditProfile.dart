import 'package:flutter/material.dart';
import 'package:share_e/view/UserInfo/ProfileScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/model/FirebaseService.dart';

class Editprofile extends StatefulWidget {
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent[700],
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[700])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[700])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "username"),
                controller: _usernameController,
              ),
              Container(
                width: 150,
                child: FlatButton(
                  child: Text("Edit"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),

                  onPressed: () {
                    final username = _usernameController.text.trim();
                    String uid;
                    SharedPreferenceHelper.readfromlocalstorage().then((user) {
                      //_profile_username = user.getusername();
                      uid = "O13DYw7p94dj3AExf8D7g77rfC72";
                      print("uid ta" + uid);

                      FirebaseService().EditUserData(username,uid);
                      SharedPreferenceHelper.updateLocalData(username);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                    });
                  },
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
