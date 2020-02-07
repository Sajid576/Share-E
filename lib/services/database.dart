import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  //creating collection in firebase
  final CollectionReference userinfo = Firestore.instance.collection('users');
  Future updateUserData(String username,String Phone)async{
    return await userinfo.document(uid).setData({
      'username':username,
      'Phone':Phone,
    });
  }

}