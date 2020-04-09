import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'dart:async';
import 'package:share_e/model/FirebaseServiceFilterModel.dart';

class GetAllSharedServiceController
{
  static  List<DocumentSnapshot> AllSharedData;
  static StreamController<List<DocumentSnapshot>> AllServicedataController=  new BehaviorSubject();

  //variables for searching Service Name
  static var queryResultSet = [];
  static var tempSearchStore = [];

  static getAllServiceData()
  {

        //Adding DocumentSnapshot List to the StreamController object to show the List data on the UI
        if(AllSharedData !=null )
          {

                AllServicedataController.add(AllSharedData);

          }
        else
          {
                 print("HEHE");
          }

  }
  static setAllServiceData(data)
  {

          AllSharedData=new List<DocumentSnapshot>();
          //Adding all list of Document Snapshot to the List
          AllSharedData.addAll(data);
          getAllServiceData();


  }
  static requestAllSharedService()
  {
        FirebaseService().getAllSharedServicePosts();

  }

   initiateSearch(value) {
    if (value.length == 0) {

        queryResultSet = [];
        tempSearchStore = [];
         AllServicedataController.add(tempSearchStore);
      //setstate
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      FirebaseServiceFilterModel().searchByService(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          print(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['service_product_name'].startsWith(capitalizedValue)) {
            tempSearchStore.add(element);
            //setState
            AllServicedataController.add(tempSearchStore);
        }
      });
    }
  }



}