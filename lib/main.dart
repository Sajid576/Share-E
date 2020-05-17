import 'package:flutter/material.dart';
import 'package:share_e/SplashScreen.dart';
import 'package:share_e/view/Messages/MessagesScreen.dart';

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
      home:SplashScreen(),
      //home:MessageScreen(),

    );
  }




}








