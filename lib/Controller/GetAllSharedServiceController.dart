import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'dart:async';
import 'package:share_e/view/GoogleMap/GoogleMapView.dart';

class GetAllSharedServiceController
{

  static  List<DocumentSnapshot> AllSharedData;

  static StreamController<List<DocumentSnapshot>> AllServicedataController  =  new BehaviorSubject();

  //variables for searching by Service Name
  static List<DocumentSnapshot> queryResultSet = [];
  //static var tempSearchStore = [];


  static setAllServiceData(data)
  {

          AllSharedData=new List<DocumentSnapshot>();
          //Adding all list of Document Snapshot to the List
          AllSharedData.addAll(data);
          //Adding DocumentSnapshot List to the StreamController object to show the List data on the UI

          AllServicedataController.add(AllSharedData);

  }
  //this controller function handles the request of fetching all shared services
  static requestAllSharedService()
  {
    if(AllSharedData==null)
      {
        //fetch the data from cloud firestore if I dont have data of shared services
          FirebaseService().getAllSharedServicePosts();
      }
    else
      {
        GoogleMapView.resetMarkers();
        //if I have data of shared services , no need to fetch from cloud rather fetch it from locally saved variable
        //to avoid CRUD operations
         AllServicedataController.add(AllSharedData);
      }


  }
  //this controller function handles the request of fetching a specific type of shared services(E.g-Shared Vehicles)
  //invoked from Right Navigation Drawyer
  static requestFilterByServiceType(serviceType)
  {
    GoogleMapView.resetMarkers();
    queryResultSet = [];
    AllSharedData.forEach((element) {

      if (serviceType==element['service_product_type']) {
        queryResultSet.add(element);

      }
    });
    AllServicedataController.add(queryResultSet);
  }

  //this controller function handles the request of fetching all shared services that contain a service/product name
  //provided by the user in the search bar

   initiateSearch(String value) {

     GoogleMapView.resetMarkers();

    if (value.length == 0) {

        queryResultSet = [];

        AllServicedataController.add(AllSharedData);
       //setstate
    }
    else
      {

        value=value.toLowerCase();

        //var capitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);

        queryResultSet = [];
        AllSharedData.forEach((element) {
          String serviceProductName= element['service_product_name'];
          serviceProductName=serviceProductName.toLowerCase();
          if (serviceProductName.startsWith(value)) {
            queryResultSet.add(element);

          }
        });
        AllServicedataController.add(queryResultSet);
      }


  }



}