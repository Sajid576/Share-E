import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeoCoder {

      //Coordinates to Address conversion
      static geoCoding(var lat, var lon) async
      {
            try {
                  List<Placemark> placemark = await Geolocator()
                      .placemarkFromCoordinates(lat, lon);
                  Placemark place = placemark[0];

                  //throughfare=The street address associated with the placemark.
                  // locality= the city name
                  String address = place.thoroughfare+","+ place.locality ;
                  print("Address:  "+address);

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
            List<Placemark> placemark = await Geolocator().placemarkFromAddress(address);
            Placemark place = placemark[0];

            return place.position;

      }

}