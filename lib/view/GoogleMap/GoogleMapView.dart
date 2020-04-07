
import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/HomeScreen.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:background_location/background_location.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';
import 'package:share_e/model/FirebaseService.dart';

class GoogleMapView{

  static BuildContext context;
  static GoogleMapController _googleMapController;


  static var _userLatitutde=0.0;
  static var _userLongitude=0.0;

  static Map<MarkerId, Marker> serviceMarkers ;

  static int currentSearchingTypeIndex;
  static String currentSearchingTypeHint;
  static UserBackgroundLocation loc;

  static StreamController<bool> locationTrackingController ;
  static StreamController<String> searchBoxParameterController;

  GoogleMapView();

  GoogleMapView.init(bool initGoogleMap)
  {
     currentSearchingTypeIndex=1;
     currentSearchingTypeHint="Search By Location";


     searchBoxParameterController= new BehaviorSubject();
     locationTrackingController = new BehaviorSubject();
     setLocationStreamController(initGoogleMap);

     serviceMarkers = <MarkerId, Marker>{};

    //start background location tracking
    loc=new UserBackgroundLocation();
    loc.getCurrentLocationUpdates();

    print("Google map initialized");


  }

  static setLocationStreamController(bool init)
  {
        locationTrackingController.add(init);

  }

  setCurrentSearchingIndex(val)
  {
    currentSearchingTypeIndex=val;
    if(currentSearchingTypeIndex==1)
      {
        currentSearchingTypeHint="Search By Location";
        searchBoxParameterController.add("Search By Location");
      }
    else
      {
        currentSearchingTypeHint="Search By Service";
        searchBoxParameterController.add("Search By Service Name");
      }

  }



  void setServiceMarker(String id,double lat,double lon,var title,var snippet,BitmapDescriptor _markerIcon)
  {


     Marker marker= Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lon),
          infoWindow: InfoWindow(
            title: title,
            snippet: snippet,
          ),
          icon: _markerIcon);

     serviceMarkers[new MarkerId(id)]=marker;


  }

   void updateUserMarker(var lat,var lon,var accuracy) {
    LatLng latlng = LatLng(lat, lon);

    _userLatitutde=lat;
    _userLongitude=lon;

    if (_googleMapController != null)
    {
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
          bearing: 192.8334901395799,
          target: latlng,
          tilt: 30,
          zoom: 18.00)));

    }
     Marker userMarker= Marker(
      markerId: MarkerId("user"),
      position: latlng,
      draggable: false,
      zIndex: 2,

    );


    serviceMarkers[new MarkerId('user')]=userMarker;
    //print("service markers length : "+serviceMarkers.length.toString());

    setLocationStreamController(true);

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
                         target: LatLng(_userLatitutde,_userLongitude),
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
                          //GetAllSharedServiceController().initiateSearch(val);
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
                              AuxiliaryClass.showToast("Searching ");

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
          print("floating action button pressed");
            new UserBackgroundLocation().getCurrentLocationUpdates();

        },
        child: Icon(Icons.my_location, semanticLabel: 'Action'),
        backgroundColor: Colors.black87,
      ),
    );










  }
}