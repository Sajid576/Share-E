import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_e/SplashScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/Authentication/LoginScreen.dart';
import 'package:share_e/view/Messages/MessagesScreen.dart';
import 'package:share_e/view/Messages/MessagesNotifier.dart';
import 'package:share_e/view/UserRecord/ShareYourServices.dart';
import 'package:share_e/view/UserRecord/YourCartList.dart';
import 'package:share_e/view/UserRecord/YourSharedService.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';


void main()  {

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home:SplashScreen(),
      home:LoginScreen(),
    );
  }




}








