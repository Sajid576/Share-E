import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

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

    return await userinfo.document(uid).setData({     //update the firebase with that coressponding uid
      'username':username,
    },merge: true);

  }

   Future getAllSharedServicePosts()async{
    //instantiate FireStore
    var firestore = Firestore.instance; //giving a FireBase instance
    QuerySnapshot qn= await firestore.collection("Shared_Services").getDocuments();//accessing shared_services documents
    //return qn.documents;  //all the documents array inside the shared_Service
    print("documents length:  "+qn.documents.length.toString());
    return qn.documents;

  }



}