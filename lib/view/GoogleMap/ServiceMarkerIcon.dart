import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMarkerIcon{

  BitmapDescriptor _bookMarkerIcon;
  BitmapDescriptor _vehicleMarkerIcon;
  BitmapDescriptor _houseMarkerIcon;
  BitmapDescriptor _medicalMarkerIcon;
  BitmapDescriptor _foodMarkerIcon;
  BitmapDescriptor _parkingMarkerIcon;
  BitmapDescriptor _mechanicMarkerIcon;

  ServiceMarkerIcon()
  {
    setMarkerIcon();
  }
  void setMarkerIcon() async
  {
    _bookMarkerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/book_ico.png');
    _vehicleMarkerIcon=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/vehicle_ico.png');
    _houseMarkerIcon= await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/house_ico.png');
    _medicalMarkerIcon=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/medical_ico.png');
    _foodMarkerIcon=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/food_ico.png');
    _parkingMarkerIcon=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/parking_ico.png');
    _mechanicMarkerIcon=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/mechanic_ico.png');
  }

  BitmapDescriptor getMarkerIcon(String service)
  {
        service=service.toLowerCase().trim();

        if(service.contains("book"))
          {
              return _bookMarkerIcon;
          }
        if(service.contains("vehicle"))
        {
            return _vehicleMarkerIcon;
        }
        if(service.contains("house"))
        {
            return _houseMarkerIcon;
        }
        if(service.contains("medical"))
        {
            return _medicalMarkerIcon;
        }
        if(service.contains("food"))
        {
            return _foodMarkerIcon;
        }
        if(service.contains("parking"))
        {
            return _parkingMarkerIcon;
        }
        if(service.contains("mechanic"))
        {
            return _mechanicMarkerIcon;
        }
  }

}