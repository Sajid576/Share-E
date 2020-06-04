import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_e/SplashScreen.dart';
import 'package:share_e/Controller/MessageController.dart';
import 'package:share_e/view/GoogleMap/HomeScreen.dart';
import 'package:share_e/view/GoogleMap/ServiceMarkerIcon.dart';
import 'package:share_e/view/Messages/MessagesScreen.dart';

void main()  {
 // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:SplashScreen(),
        debugShowCheckedModeBanner: false,
        //home:MessageScreen(),

      ),
      create: (context) => MessageController(),
    );
  }




}








