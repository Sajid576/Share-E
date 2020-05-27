import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_e/view/UserInfo/Userprofiledetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{


  
  //write purpose
  static setLocalData(String email,String phone,String username,String uid) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('phone', phone);
        prefs.setString('username', username);
        prefs.setString('uid', uid);
        prefs.setBool('session', true);

  }
  //adding value which is update in editing option
  static updateLocalData(String phone,String username) async {
        SharedPreferences prefs1 = await SharedPreferences.getInstance();
        prefs1.setString('phone', phone);
        prefs1.setString('username', username);
        prefs1.setBool('session', true);

  }
  static setUserDP(img64) async {
      SharedPreferences prefs1 = await SharedPreferences.getInstance();
       prefs1.setString('dp', img64);
  }

  static setChatRoomId(myUid,uId) async
  {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String newChatRoomId=myUid+"_"+uId;
      var myChatList = prefs.getStringList('chatRoomList')??[];
      print("myStringList: "+myChatList.toString());
      myChatList.add(newChatRoomId);
      print("myStringList: "+myChatList.toString());
      prefs.setStringList('chatRoomList',myChatList );


  }

   //read user details
  static Future<Userprofiledetails> readfromlocalstorage()async{
         SharedPreferences prefs = await SharedPreferences.getInstance();
         var dp = prefs.getString('dp') ??'';
         var phone = prefs.getString('phone') ??'';
         var username=prefs.getString('username')??'';
         var session = prefs.getBool('session')?? false;
         var uid = prefs.getString('uid')??'';
         var email = prefs.getString('email')??'';

         var myChatList = prefs.getStringList('chatRoomList')??[];

         Userprofiledetails userProfile = new Userprofiledetails(dp:dp,phone:phone,username: username,uid: uid,session: session,email: email,myChatList:myChatList);
         return userProfile;
  }

}