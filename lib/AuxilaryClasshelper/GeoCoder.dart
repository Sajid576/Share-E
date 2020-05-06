import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeoCoder {

      //Coordinates to Address conversion
      static geoCoding(var lat, var lon) async
      {
            try {
                  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat, lon);
                  Placemark place = placemark[0];

                  //throughfare=The street address associated with the placemark.
                  // locality= the city name
                  String address = place.thoroughfare+","+ place.locality ;


                  return address;
            }catch(Exception)
            {
                  print(Exception);
            }
      }

      //converts an address to Coordinates
      //Used in HomeScreen for searching a location by address name
      static ReverseGeocoding(address) async
      {
            Placemark place;
            try{
                  List<Placemark> placemark = await Geolocator().placemarkFromAddress(address);
                  place = placemark[0];
            }catch(Exception)
            {
                  print(Exception);
            }


            return place.position;

      }

}