import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';
import 'package:image/image.dart' as Images;

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

   setMarkerIcon() async
  {
         await rootBundle.load("assets/book_ico.png").then((bookByteData) =>
             _bookMarkerIcon=BitmapDescriptor.fromBytes(bookByteData.buffer.asUint8List())
        );

         await rootBundle.load("assets/vehicle_ico.png").then((vehicleByteData) =>
            _vehicleMarkerIcon=BitmapDescriptor.fromBytes(vehicleByteData.buffer.asUint8List())
        );


        await rootBundle.load("assets/house_ico.png").then((houseByteData) =>
           _houseMarkerIcon=BitmapDescriptor.fromBytes(houseByteData.buffer.asUint8List())
        );


        await rootBundle.load("assets/medical_ico.png").then((medicalByteData) =>
              _medicalMarkerIcon=BitmapDescriptor.fromBytes(medicalByteData.buffer.asUint8List())
        );


        await rootBundle.load("assets/food_ico.png").then((foodByteData) =>
        _foodMarkerIcon=BitmapDescriptor.fromBytes(foodByteData.buffer.asUint8List())

        );

        await rootBundle.load("assets/parking_ico.png").then((parkingByteData) =>
               _parkingMarkerIcon=BitmapDescriptor.fromBytes(parkingByteData.buffer.asUint8List())

        );

        await rootBundle.load("assets/mechanic_ico.png").then((mechanicByteData) =>
              _mechanicMarkerIcon=BitmapDescriptor.fromBytes(mechanicByteData.buffer.asUint8List())

        );


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