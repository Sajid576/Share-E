import 'package:geocoder/geocoder.dart';


class GeoCoder{

      static geoCoding(var lat,var lon) async
      {
          // From coordinates
          final coordinates = new Coordinates(lat, lon);
          var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
          var first = addresses.first;
          print(""+first.featureName +" ___"+first.addressLine);

      }

      static reverseGeoCoding(var query) async
      {
          var addresses = await Geocoder.local.findAddressesFromQuery(query);
          var first = addresses.first;
          print(""+first.featureName +" ___"+first.coordinates.toString());
      }

}