import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:share_e/view/GoogleMapView.dart';
import 'package:share_e/view/HomeScreen.dart';

class UserBackgroundLocation
{


  UserBackgroundLocation()
  {
      BackgroundLocation.startLocationService();
      print("background location initialized");
  }
  void getCurrentLocationUpdates() async {

    print("getCurrentLocation called");
    BackgroundLocation.getLocationUpdates((location) {
      var latitude = location.latitude;
      var longitude = location.longitude;
      var accuracy = location.accuracy;


      print("latitude:  "+latitude.toString() +"  longitude: "+longitude.toString());

      new GoogleMapView().updateUserMarker(latitude,longitude,accuracy);

    });

  }

  void stopLocationService()
  {
    BackgroundLocation.stopLocationService();

    GoogleMapView.setStreamContoller(false);



  }

}