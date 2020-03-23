import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{

  //this function set/overwrites the user data corresponding to the uid
  Future setUserData(String username,String Phone,String uid)async{
    final CollectionReference userinfo = Firestore.instance.collection('users');

    return await userinfo.document(uid).setData({
      'username':username,
      'Phone':Phone,
    });

  }

  //this function updates a specific field corresponding to the uid
  Future EditUserData(String username,String uid)async{
    final CollectionReference userinfo = Firestore.instance.collection('users'); //instatiate the firebase

    return await userinfo.document(uid).setData({     //updat the firebase with that coressponding uid
      'username':username,
    },merge: true);

  }





}