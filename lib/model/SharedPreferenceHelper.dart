import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';

class SharedPreferenceHelper{

  static void logout() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('session', false);
  }

  
  //write purpose
  static setLocalData(String phone,String username,String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
    prefs.setString('username', username);
    prefs.setString('Uid', uid);
    prefs.setBool('session', true);

  }
  //adding value which is update in editing option
  static updateLocalData(String username) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    prefs1.setString('username', username);

    //prefs1.setBool('session', true);

  }
   //read purpose
  static Future<Userprofiledetails> readfromlocalstorage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   var phone = prefs.getString('phone') ??'';
   var username=prefs.getString('username')??'';
   var session = prefs.getBool('session')?? false;
   var uid = prefs.getString('uid')??'';


   Userprofiledetails userprofile = new Userprofiledetails(phone:phone,username: username,uid: uid,session: session);
    return userprofile;
  }

}