import 'package:flutter/material.dart';
import 'package:share_e/view/GoogleMapView.dart';
import 'package:share_e/view/ProfileScreen.dart';
import 'package:share_e/view/LoginScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';
import 'package:share_e/view/AllSharedServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:share_e/model/FirebaseService.dart';

class FutureHolder
{
  static Future data;

  requestAllSharedService()
  {
        print("Data requested:  "+data.toString());
        data=FirebaseService().getAllSharedServicePosts();
  }

}