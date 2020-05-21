import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:share_e/view/GoogleMap/GoogleMapView.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';

class UserBackgroundLocation
{

  UserBackgroundLocation.init()
  {
      BackgroundLocation.getPermissions(
        onGranted: () {
          // Start location service here or do something else
          BackgroundLocation.startLocationService();
          print("background location initialized");
        },
        onDenied: () {
          // Show a message asking the user to reconsider or do something else

        },
      );
  }

  static getCurrentLocationUpdates() async {

    print("getCurrentLocation called");
    BackgroundLocation.getLocationUpdates((location) {
      var latitude = location.latitude;
      var longitude = location.longitude;
      var accuracy = location.accuracy;


      print("latitude:  "+latitude.toString() +"  longitude: "+longitude.toString());

      new GoogleMapView().updateUserMarker(latitude,longitude,accuracy);

    });

  }

  static stopLocationService()
  {
    BackgroundLocation.stopLocationService();


  }

}