import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_e/AuxilaryClasshelper/Userprofiledetails.dart';

class SharedPreferenceHelper{
  //write purpose
  static addtolocalstoage(String phone,String username,String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
    prefs.setString('username', username);
    prefs.setString('Uid', uid);
    prefs.setBool('session', true);

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