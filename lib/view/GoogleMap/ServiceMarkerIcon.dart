import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';

class ServiceMarkerIcon{

  static var  _bookMarkerIcon;
  static var _vehicleMarkerIcon;
  static var _houseMarkerIcon;
  static var _medicalMarkerIcon;
  static var _foodMarkerIcon;
  static var _parkingMarkerIcon;
  static var _mechanicMarkerIcon;


  ServiceMarkerIcon.init()
  {
      setMarkerIcon();
      print("Service marker set");
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