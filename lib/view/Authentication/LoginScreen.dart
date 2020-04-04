import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_e/ExceptionHandeling/CustomException.dart';
import 'dart:io';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _codeController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();




  Future<bool> loginUser(
      String phone, String username, BuildContext context) async {

      FirebaseAuth _auth = FirebaseAuth.instance;
      try {                                                     //internet exception
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected to internet');
          _auth.verifyPhoneNumber(
              phoneNumber: phone,
              timeout: Duration(seconds: 60),
              verificationCompleted: (AuthCredential credential) async {
                Navigator.of(context).pop();

                AuthResult result = await _auth.signInWithCredential(credential);

                FirebaseUser user = result.user;


                if (user != null) {
                  print(username+"  verified");
                  print(phone+"  verified");
                  print(user.toString()+"  verified");

                  //data storing in FireStore in (FireBaseService.dart)
                  await FirebaseService().setUserData(username, phone,user.uid);
                  //data storing local storage
                  SharedPreferenceHelper.setLocalData(phone,username,user.uid);
                  AuxiliaryClass.showToast("You are logged in!!");


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                } else {
                  print("Error");
                }

                //This callback would gets called when verification is done automaticlly
              },
              verificationFailed: (AuthException exception) {
                print(exception.toString());
              },
              codeSent: (String verificationId, [int forceResendingToken]) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Give the code?"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: _codeController,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Confirm"),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () async {
                              final code = _codeController.text.trim();
                              AuthCredential credential = PhoneAuthProvider.getCredential(
                                  verificationId: verificationId,
                                  smsCode: code);

                              AuthResult result = await _auth.signInWithCredential(credential);

                              FirebaseUser user = result.user;

                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(

                                        )));
                              } else {
                                print("Error");
                              }
                            },
                          )
                        ],
                      );
                    });
              },
              codeAutoRetrievalTimeout: null);
        }
      } on SocketException catch (_) {
        print('not connected');
        AuxiliaryClass.showToast("check your internet connection");
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "username"),
                    controller: _usernameController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("LOGIN"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        String phone = _phoneController.text.trim();
                        final username = _usernameController.text.trim();
                        print(phone);
                        print(username);

                        if (phone.isEmpty || username.isEmpty) {
                          CustomException.ExceptionHandeling(1);
                        } else {

                            loginUser("+88" + phone, username, context);


                        }
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
