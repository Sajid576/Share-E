import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  Future setUserData(String username,String Phone,String uid)async{
    final CollectionReference userinfo = Firestore.instance.collection('users');

    return await userinfo.document(uid).setData({
      'username':username,
      'Phone':Phone,
    });

  }





}