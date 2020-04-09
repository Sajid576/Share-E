import 'package:flutter/material.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:share_e/view/UserRecord/ShareYourServices.dart';

class FirebaseWrapper {

  static FirebaseAuth _auth;
  static Firestore _firestore;
  static FirebaseStorage _storage;


  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    final FirebaseApp app = await FirebaseApp.configure(
      name: 'Overload',
      options: FirebaseOptions(
        googleAppID: '1:556320559446:android:46e924c5bb79c50daa46f7',
        gcmSenderID: '556320559446',
        apiKey: 'AIzaSyAVP4q06zApK6ndsjZ934T4TcYhhs6l508',
        projectID: 'shareeverything-78bb8',
      ),
    );

    _auth = FirebaseAuth.fromApp(app);

    _firestore = Firestore(app: app);

    _storage = FirebaseStorage(
        app: app, storageBucket: 'gs://overload-57752.appspot.com');
  }

  static FirebaseAuth auth() {
    return _auth;
  }

  static Firestore firestore() {
    return _firestore;
  }

  static FirebaseStorage storage() {
    return _storage;
  }
}


void main()  {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static bool _isSignedUp=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //autoLogin();

  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: HomeScreen(),

         // home: _isSignedUp ==true ? HomeScreen() : LoginScreen(),




    );
  }


  void autoLogin() async {

    SharedPreferenceHelper.readfromlocalstorage().then((user)
    {

      print('signedup?? '+user.getsession().toString());

      bool isSignedUp=  user.getsession();

      setState(() {
        _isSignedUp=isSignedUp;
      });
    });

  }
}








