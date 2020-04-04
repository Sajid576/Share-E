import 'dart:async';

import 'package:background_location/background_location.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/GoogleMapView.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/HomeScreen.dart';

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

    GoogleMapView.setLocationStreamController(false);



  }

}