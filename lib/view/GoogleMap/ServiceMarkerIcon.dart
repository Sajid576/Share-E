import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';

class ServiceMarkerIcon{

  static BitmapDescriptor  _bookMarkerIcon;
  static BitmapDescriptor _vehicleMarkerIcon;
  static BitmapDescriptor _houseMarkerIcon;
  static BitmapDescriptor _medicalMarkerIcon;
  static BitmapDescriptor _foodMarkerIcon;
  static BitmapDescriptor _parkingMarkerIcon;
  static BitmapDescriptor _mechanicMarkerIcon;


  ServiceMarkerIcon.init()
  {
      setMarkerIcon();
      print("Service marker set");
  }

  void setMarkerIcon() async
  {
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/book_ico.png').then((value) {
          _bookMarkerIcon=value;
        });
        await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/vehicle_ico.png').then((value) =>
        _vehicleMarkerIcon=value);
       await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/house_ico.png').then((value) =>
       _houseMarkerIcon=value);
       await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/medical_ico.png').then((value) =>
       _medicalMarkerIcon=value);
       await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/food_ico.png').then((value) =>
       _foodMarkerIcon=value);
       await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/parking_ico.png').then((value) =>
       _parkingMarkerIcon=value);
       await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/mechanic_ico.png').then((value) =>
       _mechanicMarkerIcon=value);


  }

  static getMarkerIcon(String service)
  {
    service=service.trim();
    print("Service: "+service);

    if(service.contains(ServiceTypeController.book))
    {
      print("PAISI");
        return _bookMarkerIcon;
    }
    if(service.contains(ServiceTypeController.vehicle))
    {
      return _vehicleMarkerIcon;
    }
    if(service.contains(ServiceTypeController.houseRent))
    {
      return _houseMarkerIcon;
    }
    if(service.contains(ServiceTypeController.medicine))
    {
      return _medicalMarkerIcon;
    }
    if(service.contains(ServiceTypeController.food))
    {
      return _foodMarkerIcon;
    }
    if(service.contains(ServiceTypeController.parking))
    {
      return _parkingMarkerIcon;
    }
    if(service.contains(ServiceTypeController.mechanic))
    {
      return _mechanicMarkerIcon;
    }
  }

}