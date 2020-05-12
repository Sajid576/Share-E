import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class SignInPage extends StatefulWidget {
  final String title = 'Login';
  @override
  State<StatefulWidget> createState() => SignInPageState();
}


class SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: Colors.black,
      ),

      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: const Text('Test sign in with email and password'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            TextFormField(
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
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Mobile No.'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your valid Mobile No.';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
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
        password: _passwordController.text,
      )).user;
      if (user != null) {
        setState(() {
          AuxiliaryClass.showToast(user.email+" successfully logged in");
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


