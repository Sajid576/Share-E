import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/view/Authentication/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class LoginScreen  extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen > {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign In')),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(

        child: SafeArea(
          child: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.centerLeft,
                end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
                colors: [Color(0xFF444152),  Color(0xFF6f6c7d)], // whitish to gray
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
                    child: Center(
                      child: new Column(
                        children: <Widget>[
                          Container(
                            height: 128.0,
                            width: 128.0,
                            child: new CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              radius: 100.0,
                              child: new Text(
                                "S",
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                              shape: BoxShape.circle,
                              //image: DecorationImage(image: this.logo)
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: new Text(
                              "Share-E",
                              style: TextStyle(color:Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color:Colors.white,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Padding(
                          padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                          child: Icon(
                            Icons.alternate_email,
                            color: Colors.white,
                          ),
                        ),
                        new Expanded(
                          child:  TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.white,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Padding(
                          padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                          child: Icon(
                            Icons.lock_open,
                            color: Colors.white,
                          ),
                        ),
                        new Expanded(
                          child:   TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(labelText: 'Password'),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter valid password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    color: Colors.green[600],
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _signInWithEmailAndPassword();
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            color: Colors.transparent,
                            onPressed: () => {},
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(color: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Expanded(
                    child: Divider( color: Colors.white,
                    height: 10,
                    thickness: 4,
                    indent: 20,
                    endIndent: 0,),

                  ),

                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 80.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            padding: const EdgeInsets.all(10),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              "Don't have an account? Create One",
                              style: TextStyle(color: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )).user;
      if (user != null) {
        setState(() {

          AuxiliaryClass.showToast(user.email+" successfully logged in");
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen() ));

        });
      } else {
        AuxiliaryClass.showToast(user.email+" failed log in");
      }
    } on PlatformException catch (err) {
      AuxiliaryClass.showToast(err.message);
    } catch (err) {
      AuxiliaryClass.showToast(err.message);
    }
  }
}
