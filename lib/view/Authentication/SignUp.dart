import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/Authentication/Login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  final String title = 'Sign Up';
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
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
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter the email address';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration:InputDecoration( hintText: 'password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter a password with more than 5 digits';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration( hintText: 'username',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration:  InputDecoration( hintText: 'mobile no',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
              validator: (String value) {
                if (value.isEmpty&&value.length!=11) {
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
                    _register();
                  }
                },
                child: const Text('Register'),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  // Example code for registration.
  void _register() async {
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )).user;
      if (user != null) {
        SharedPreferenceHelper.setLocalData(_emailController.text.trim(), _userNameController.text.trim(), _phoneController.text.trim(), user.uid);
        FirebaseService().setUserData(_emailController.text.trim(), _userNameController.text.trim(), _phoneController.text.trim(), user.uid);
        AuxiliaryClass.showToast(user.email+" is successfully signed up");

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen() ));

      } else {
        AuxiliaryClass.showToast(user.email+" failed signed up");
      }
    } on PlatformException catch (err) {
        AuxiliaryClass.showToast(err.message);
    } catch (err) {
        AuxiliaryClass.showToast(err.message);
    }
  }
}