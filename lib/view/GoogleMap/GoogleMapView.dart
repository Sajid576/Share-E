import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/AuxilaryClasshelper/GeoCoder.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/Controller/YourStreamController.dart';
import 'package:share_e/view/GoogleMap/AllSharedServices.dart';
import 'package:share_e/view/GoogleMap/AllSharedServiceDetail.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';

class GoogleMapView{

  static BuildContext context;
  static GoogleMapController _googleMapController;


  static var userLatitutde=0.0;
  static var userLongitude=0.0;

  static Map<MarkerId, Marker> serviceMarkers ;

  static int currentSearchingTypeIndex;
  static String currentSearchingTypeHint;
  static String searchingVal="";

  static UserBackgroundLocation loc;




  GoogleMapView();

  static resetMarkers()
  {
      serviceMarkers = <MarkerId, Marker>{};
  }

  GoogleMapView.init(bool initGoogleMap)
  {

     currentSearchingTypeIndex=1;
     currentSearchingTypeHint="Search By Location";

     YourStreamController.HomeScreenController=new BehaviorSubject();

     setYourStreamController(initGoogleMap);

     serviceMarkers = <MarkerId, Marker>{};

      //check for user permission and start background location tracking
      loc=new UserBackgroundLocation.init();
      UserBackgroundLocation.getCurrentLocationUpdates();

      print("Google map initialized");


  }

  static setYourStreamController(bool init)
  {
       YourStreamController.HomeScreenController.add(init);

  }

  setCurrentSearchingIndex(val)
  {
    currentSearchingTypeIndex=val;
    if(currentSearchingTypeIndex==1)
      {
        currentSearchingTypeHint="Search By Location";
        YourStreamController.HomeScreenController.add("Search By Location");
      }
    else
      {
        currentSearchingTypeHint="Search By Service";
        YourStreamController.HomeScreenController.add("Search By Service Name");
      }

  }


  navigateToDetailPage(BuildContext context,DocumentSnapshot sharedServices)
  {
    print("navigate");
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AllSharedServiceDetail(sharedServices: sharedServices))
    );
  }
  void setServiceMarker(String id,double lat,double lon,var title,var snippet,var doc,BitmapDescriptor imageIcon)
  {


     Marker marker= Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lon),
          icon: imageIcon,
          infoWindow: InfoWindow(
            title: title,
            snippet: snippet,
              onTap: (() {
                // InfoWindow clicked
                navigateToDetailPage(context,doc);
              }),
          ),
          );

        serviceMarkers[new MarkerId(id)]=marker;

  }

   void updateUserMarker(var lat,var lon,var accuracy) {
    LatLng latlng = LatLng(lat, lon);

    userLatitutde=lat;
    userLongitude=lon;


     Marker userMarker= Marker(
      markerId: MarkerId("user"),
      position: latlng,
      draggable: false,
      zIndex: 2,

    );


    serviceMarkers[new MarkerId('user')]=userMarker;
    //print("service markers length : "+serviceMarkers.length.toString());



  }
  void _onMapCreated(GoogleMapController controller) {
     _googleMapController = controller;
  }
  //google map widget
  Widget googleMapLayout()
  {
    return  Scaffold(

      body: Stack(
        overflow: Overflow.visible,   //this property shows the all children in stack.Without it ,screen showed only floating textfield in the map tab.
        children: <Widget>[
          GoogleMap(

            //gestureRecognizer used for moving the view of google map by swiping
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
            ].toSet(),

            mapType: MapType.normal,

            initialCameraPosition: CameraPosition(
                         target: LatLng(userLatitutde,userLongitude),
                         zoom: 17,
            ),
            markers: Set<Marker>.of(serviceMarkers.values),
            onMapCreated: _onMapCreated,
            compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,

          ),

          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[

                  //this icon button used for selecting the searching parameter
                  IconButton(
                    splashColor: Colors.grey,
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      //here a alert dialog box with drop down menu will be created
                      AuxiliaryClass.displayAlertDialog(context,currentSearchingTypeIndex);

                    },
                  ),

                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      onChanged: (val) {
                          searchingVal=val;
                          if(val.length==0)
                            {
                              GetAllSharedServiceController().initiateSearch(searchingVal);
                            }

                      },

                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:EdgeInsets.symmetric(horizontal: 15),
                          hintText: currentSearchingTypeHint),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child:IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.search),
                      onPressed: () {
                              if(currentSearchingTypeIndex==1)
                                {
                                    AuxiliaryClass.showToast("Searching Location");
                                    GeoCoder.ReverseGeocoding(searchingVal).then((val){
                                              print("GEocoding position: "+val.latitude.toString()+","+val.longitude.toString());
                                            if (_googleMapController != null)
                                            {

                                              _googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                                                  bearing: 192.8334901395799,
                                                  target: LatLng(val.latitude,val.longitude),
                                                  tilt: 30,
                                                  zoom: 18.00)));

                                            }
                                    }) ;
                                }
                              else
                                {
                                     AuxiliaryClass.showToast("Searching Service");
                                     //if searching by Service/Product name is selected
                                     GetAllSharedServiceController().initiateSearch(searchingVal);

                                }

                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //print("floating action button pressed");
          UserBackgroundLocation.getCurrentLocationUpdates();

          if (_googleMapController != null)
          {

            _googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(userLatitutde,userLongitude),
                tilt: 30,
                zoom: 18.00)));

          }

        },
        child: Icon(Icons.my_location, semanticLabel: 'Action'),
        backgroundColor: Colors.black87,
      ),
    );










  }
}