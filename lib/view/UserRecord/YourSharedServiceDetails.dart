import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/AuxilaryClasshelper/GeoCoder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
class YourSharedServiceDetails extends StatefulWidget {
  final DocumentSnapshot Yoursharedservice;
  YourSharedServiceDetails({this.Yoursharedservice});
  @override
  _YourSharedServiceDetailsState createState() => _YourSharedServiceDetailsState();
}

class _YourSharedServiceDetailsState extends State<YourSharedServiceDetails> {

  bool isButtonPressed=false;

  bool editEnabled=false;

  String _ServiceProductname="";
  String _Price="";
  String  _AvailableTime="";
  String _ServiceId="";
  GeoPoint  _Area;
  String address;

  TextEditingController _serviceProductNameEditingController;
  TextEditingController _priceEditingController;
  TextEditingController _availableTimeEditingController;
  TextEditingController _addressEditingController;

  //Google Map related variables
  static GoogleMapController _googleMapController;
  static Map<MarkerId, Marker> serviceMarkers ;
  @override
  void initState() {
        super.initState();
        //Google Map realated variables instantiated
        serviceMarkers = <MarkerId, Marker>{};


        //fetching data from Listview that came from firestore
        _ServiceProductname=widget.Yoursharedservice.data["service_product_name"];
        _Price=widget.Yoursharedservice.data["price"];
        _AvailableTime=widget.Yoursharedservice.data["available_time"];

        //the texts that cant be changed directly through the textbox
        _ServiceId=widget.Yoursharedservice.data["service_id"];

        _Area=widget.Yoursharedservice.data["area"];  //return coordinates
        GeoCoder.geoCoding(_Area.latitude,_Area.longitude).then((addrss){
               setState(() {
                     address=addrss;
               });

        });   //retuns address in form of string

        setMarkers(_Area.latitude,_Area.longitude);




        //the text widgets that can be edited are initialized below
        _serviceProductNameEditingController = TextEditingController(text: _ServiceProductname);
        _priceEditingController=TextEditingController(text:_Price);

        //this text widget will be changed when Starting time or Ending time will be changed
        _availableTimeEditingController=TextEditingController(text:_AvailableTime);

        //this text widget will be  changed when marker of the google map will be changed
        _addressEditingController=TextEditingController(text:address);

  }

  @override
  void dispose()
  {
      super.dispose();
      _serviceProductNameEditingController.dispose();
      _priceEditingController.dispose();
      _availableTimeEditingController.dispose();


  }

  void setMarkers(lat,lon)
  {
        Marker marker= Marker(
              markerId: MarkerId("Your Marker"),
              position: LatLng(lat, lon),

        );

        serviceMarkers[MarkerId("Your Marker")]=marker;

  }
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }
  //this method used for dynamically fetching image URL ,set them on a list of widgets
  List<Widget> CaroselImageGenarator()
  {
    String Images=widget.Yoursharedservice.data["images"];
    List<String>imageUrl;
    if(Images!=null)
    {
      Images=Images.trim();
      imageUrl= Images.split(",");

      print("length:  "+imageUrl.length.toString());
    }
    List imageWidgets = new List<Widget>();
    for(var i=0;i<imageUrl.length;i++)
    {
      imageWidgets.add(
        CachedNetworkImage(
          imageUrl:imageUrl[i],
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    }
    return imageWidgets;

  }
  @override
  Widget build(BuildContext context) {
    double mapHeight=200;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Yoursharedservice.data["service_product_type"]),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body:SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              //slide showing
              Center(
                child: SizedBox(
                    width: double.infinity,
                    height: 200,

                    child: Carousel(                     //Carousel image showing
                      images: CaroselImageGenarator(),

                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.black.withOpacity(0.5),
                      borderRadius: true,
                    )
                ),
              ),
              SizedBox(height: 50,),

              //**  Information about the service  ***
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: RaisedButton(
                        child:isButtonPressed ?  Text("Start Service") : Text("Stop Service"),
                        color: isButtonPressed ? Colors.green : Colors.red,
                        onPressed: () {
                          setState(() {
                            isButtonPressed =!isButtonPressed;
                          });
                        },
                        textColor: Colors.yellow,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey,
                      ),
                    ),

                    Text("Service Name: ",style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold
                    ),),
                    TextField(
                      enabled: editEnabled,
                      onChanged: (text) {
                        _serviceProductNameEditingController.text = text;
                      },
                      controller: _serviceProductNameEditingController,
                    ),

                    Text("Service id : ",style: TextStyle(fontSize: 18),),
                    Text(_ServiceId,style: TextStyle(fontSize: 18),),
                    SizedBox(height: 20,),

                    Text("price : ",style: TextStyle(fontSize: 18),),
                    TextField(
                        enabled: editEnabled,
                        onChanged: (text) {

                          _priceEditingController.text = text;
                        },
                      controller: _priceEditingController,
                    ),
                    SizedBox(height: 20,),
                    Text("Available Time : ",style: TextStyle(fontSize: 18),),
                    TextField(
                      enabled: false,
                      controller: _availableTimeEditingController,
                    ),

                    SizedBox(height: 20,),

                    Text("Address : ",style: TextStyle(fontSize: 18),),
                    TextField(
                      enabled: false,
                      controller: _addressEditingController,
                    ),
                    SizedBox(height: 20,),

                    Container(
                      width: double.infinity,
                      height: mapHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 3),
                        ],
                      ),
                      child: GoogleMap(

                        //gestureRecognizer used for moving the view of google map by swiping
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                        ].toSet(),

                        mapType: MapType.normal,

                        initialCameraPosition: CameraPosition(
                          target: LatLng(_Area.latitude,_Area.longitude),
                          zoom: 17,
                        ),
                        markers: Set<Marker>.of(serviceMarkers.values),
                        onMapCreated: _onMapCreated,
                        onCameraMove: (CameraPosition position) {
                          if(editEnabled)
                          {
                                print("lat: " + position.target.latitude.toString() + " lon: " + position.target.longitude.toString());
                                _Area = GeoPoint(position.target.latitude, position.target.longitude);

                                if (serviceMarkers.length > 0) {
                                  MarkerId markerId = MarkerId("Your Marker");
                                  Marker marker = serviceMarkers[markerId];
                                  Marker updatedMarker = marker.copyWith(
                                    positionParam: position.target,
                                  );

                                  setState(() {
                                    serviceMarkers[markerId] = updatedMarker;
                                  });
                                }
                              }
                         




                        },
                      ),

                    )

                  ],
                ),
              ),

               SizedBox(height: 40,),
               //button Stop service

               RaisedButton(
                 child:editEnabled ? Text("Save") :  Text("Edit"),
                 color: editEnabled ? Colors.green : Colors.red,
                 onPressed: () {
                   setState(() {
                     editEnabled =!editEnabled;
                   });
                 },
                 textColor: Colors.yellow,
                 padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                 splashColor: Colors.grey,
               ),
            ],
          ),
        ),
      ) ,
    );
  }
}