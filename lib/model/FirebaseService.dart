import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';
import 'package:share_e/Controller/YourStreamController.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';

class FirebaseService{

  //this function set/overwrites the user data corresponding to the uid
  Future setUserData(String email,String username,String Phone,String uid)async{
    final CollectionReference userinfo = Firestore.instance.collection('users');

    return await userinfo.document(uid).setData({
      'email':email,
      'username':username,
      'Phone':Phone,
    });

  }

  //this function updates a specific field corresponding to the uid
  static editUserData(String phone,String username,String uid)async{
    final CollectionReference userinfo = Firestore.instance.collection('users'); //instatiate the firebase

     userinfo.document(uid).setData({     //update the firebase with that coressponding uid
      'username':username,
       'Phone':phone,
    },merge: true);

  }
  //this function used for fetching user data from cloud firestore and store it into local storage(Shared Preference)
  static readCloudUserData(uid)async{
    var query =  Firestore.instance.collection('users').document(uid);
    query.get().then((snapshot) {
      if (snapshot.exists) {
        SharedPreferenceHelper.setLocalData(snapshot.data['email'],snapshot.data['Phone'],snapshot.data['username'], uid);
      }
      else{
        print("No such user");
      }

    });
  }

  //this function used to validate username .
  static Future<dynamic> validateUsername(username) async {

    var fireStore =  Firestore.instance.collection('users');
    var query=await fireStore.where("username",isEqualTo: username).getDocuments();
    if(query.documents.length>0)
    {
        print("Username already exists");
        return 0;
    }
    else
      {
        print("Username does not already exist");
        return 1;
      }


  }

  //this function will be called from Controller
  getAllSharedServicePosts()async{

          var firestore = Firestore.instance;
           await firestore.collection("Shared_Services").where("active",isEqualTo: 1).getDocuments().then((query){
             print("*************DATA queried: "+query.documents.length.toString());
             GetAllSharedServiceController.setAllServiceData(query.documents);

          });//accessing shared_services documents
          //return qn.documents;  //all the documents array inside the shared_Service


  }

  //this function used to get a particular user's Cartlist
  //it is called from YourCartList()
   getCartList(_uid)async{

    var query = await Firestore.instance.collection("Cart").document(_uid);
    // print("Getpost "+_uid);
    List<dynamic> docs=new List<dynamic>();

    query.get().then((snapshot) async{

      //service uid  will be in values
      List<String>values=List.from(snapshot.data["Service_list"]);
      print("Values "+values.toString());
      for(var i=0;i<values.length;i++){

        await Firestore.instance.collection("Shared_Services").document(values[i]).get().then((query){
          docs.add(query);
        });
      }

      print("doc size"+docs.length.toString());
      YourStreamController.CartListstreamController.add(docs);

    });



  }




  //It is called from YourShared Service Page
  EditYourServiceData(ServiceId,ServiceName,Price,StartingTime,EndingTime)
  {
        String availableTime=StartingTime+"-"+EndingTime;
        final CollectionReference userinfo = Firestore.instance.collection('Shared_Services');

         userinfo.document(ServiceId).setData({
          'service_id':ServiceId,
          'service_product_name':ServiceName,
          'price':Price,
          'available_time':availableTime,
        },merge: true).then((value) {
            print("Data Edited Successfully");
            AuxiliaryClass.showToast("Data Edited Successfully");
        });

  }
  //this function used for stopping/starting a Service
  setActiveService(ServiceId,status)
  {
        final CollectionReference userinfo = Firestore.instance.collection('Shared_Services');

        userinfo.document(ServiceId).setData({
            'active_state':status,
        },merge: true).then((value) {
          if(status==1)
            {
              print("Service Started");
              AuxiliaryClass.showToast("Service Started");
            }
          else{
              print("Service Stopped");
              AuxiliaryClass.showToast("Service Stopped");
          }

        });
  }

  static AddToCart(uid,ServiceId)
  {

       final CollectionReference ref = Firestore.instance.collection('Cart');

        var list=new List<String>();
        list.add(ServiceId);

       ref.document(uid).setData({
          'Service_list': FieldValue.arrayUnion(list)
        },merge: true).then((value) {
            AuxiliaryClass.showToast("Added item to Cart");
       });
  }





}



