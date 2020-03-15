
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:background_location/background_location.dart';
import 'HomeScreen.dart';

class GoogleMapView {


  static Marker marker;
  static Circle circle;
  static GoogleMapController _googleMapController;

  var _initial_lat;
  var _initial_lon;

  get_googleMapController()
  {
    return _googleMapController;
  }
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(23.2324324, 90.31232),
    zoom: 14.4746,
  );


  //google map widget
   Widget googleMapLayout(context)
  {
        return GoogleMap(

          //gestureRecognizer used for moving the view of google map by swiping
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
          ].toSet(),

            mapType: MapType.hybrid,

            initialCameraPosition: initialLocation,
            markers: Set.of((marker != null) ? [marker] : []),
            circles: Set.of((circle != null) ? [circle] : []),

            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
            },

          );


  }
}