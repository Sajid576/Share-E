import 'package:share_e/model/FirebaseService.dart';
import 'dart:async';


class FutureHolder
{
  static Future data;

  requestAllSharedService()
  {
        print("Data requested:  "+data.toString());
        data=FirebaseService().getAllSharedServicePosts();
  }

}