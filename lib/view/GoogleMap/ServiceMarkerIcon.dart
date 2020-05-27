import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';


class ServiceMarkerIcon{

  static BitmapDescriptor  _bookMarkerIcon;
  static BitmapDescriptor _vehicleMarkerIcon;
  static BitmapDescriptor _houseMarkerIcon;
  static BitmapDescriptor _medicalMarkerIcon;
  static BitmapDescriptor _foodMarkerIcon;
  static BitmapDescriptor _parkingMarkerIcon;
  static BitmapDescriptor _mechanicMarkerIcon;

  
  static dynamic iconImageList=[];

  ServiceMarkerIcon()
  {
      iconImageList.add("assets/book_ico.png");
      iconImageList.add("assets/vehicle_ico.png");
      iconImageList.add("assets/house_ico.png");
      iconImageList.add("assets/medical_ico.png");
      iconImageList.add("assets/food_ico.png");
      iconImageList.add("assets/parking_ico.png");
      iconImageList.add("assets/mechanic_ico.png");

      for(var i=0;i<iconImageList.length;i++)
        {
              setMarkerIcon(iconImageList[i],Size(50.0,50.0)).then((value) {
                    print("VALUE::: "+value.toString());
                    if(iconImageList[i].contains("book"))
                      {
                          _bookMarkerIcon=value;
                      }
                    if(iconImageList[i].contains("vehicle"))
                    {
                          _vehicleMarkerIcon=value;
                    }
                    if(iconImageList[i].contains("house"))
                    {
                           _houseMarkerIcon=value;
                    }
                    if(iconImageList[i].contains("medical"))
                    {
                          _medicalMarkerIcon=value;
                    }
                    if(iconImageList[i].contains("food"))
                    {
                          _foodMarkerIcon=value;
                    }
                    if(iconImageList[i].contains("parking"))
                    {
                         _parkingMarkerIcon=value;
                    }
                    if(iconImageList[i].contains("mechanic"))
                    {
                          _mechanicMarkerIcon=value;
                    }

              });
        }

  }


  Future<ui.Image> getImageFromPath(String imagePath) async {
    //String imgPath =  await rootBundle.loadString(imagePath);
    //print("--->"+imgPath);
/*

    //File imageFile = File(path+"/"+imagePath);
    ByteData bytes = await rootBundle.load(imagePath);
    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;  */
  }

  Future<BitmapDescriptor> setMarkerIcon(String imagePath, Size size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              0.0,
              0.0,
              size.width,
              size.height
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              shadowWidth,
              shadowWidth,
              size.width - (shadowWidth * 2),
              size.height - (shadowWidth * 2)
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width - tagWidth,
              0.0,
              tagWidth,
              tagWidth
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: '1',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(
            size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2
        )
    );

    // Oval for the image
    Rect oval = Rect.fromLTWH(
        imageOffset,
        imageOffset,
        size.width - (imageOffset * 2),
        size.height - (imageOffset * 2)
    );

    // Add path for oval image
    canvas.clipPath(Path()
      ..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(imagePath); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(),
        size.height.toInt()
    );

    // Convert image to bytes
    final ByteData byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
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
    else
      {
        return null;
      }

  }

}