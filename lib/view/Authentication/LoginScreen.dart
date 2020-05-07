import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:share_e/view/Authentication/OTPScreen.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_e/ExceptionHandeling/CustomException.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();

  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("in validate : ${_phoneNumberController.text.length}");
    if (_phoneNumberController.text.length == 11) {
      updateState(() {
        isValid = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder:  (BuildContext context, StateSetter state){
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
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    autofocus: true,
                    onChanged: (text) {
                      validate(state);
                    },
                    decoration: InputDecoration(
                      labelText: "11 digit mobile number",
                      prefix: Container(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "+880",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    autovalidate: true,
                    autocorrect: false,
                    maxLengthEnforced: true,
                    validator: (value) {
                      return !isValid
                          ? 'Please provide a valid 11 digit phone number'
                          : null;
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: SizedBox(
                        width:  MediaQuery.of(context).size.width * 0.85,
                        child: RaisedButton(
                          color: !isValid
                              ? Theme.of(context)
                              .primaryColor
                              .withOpacity(0.5)
                              : Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(0.0)),
                          child: Text(
                            !isValid
                                ? "ENTER PHONE NUMBER"
                                : "CONTINUE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (isValid) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OTPScreen(
                                          mobileNumber:
                                          _phoneNumberController.text,username: _usernameController.text,
                                        ),
                                  ));
                            } else {
                              validate(state);
                            }
                          },
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    );
  }
}
