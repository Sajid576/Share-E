import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/AuxilaryClasshelper/GeoCoder.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'ShareServiceProductHelper.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:share_e/Controller/ShareYourServiceController.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';
import 'package:share_e/view/GoogleMap/GoogleMapView.dart';

class ShareYourServices  extends StatefulWidget {
  @override
  _ShareYourServicesState createState() => _ShareYourServicesState();
}

class _ShareYourServicesState extends State<ShareYourServices> {
  static var theme;

  final _UserName=TextEditingController();
  final _addressEditingController = TextEditingController();
  TimeOfDay time1;
  TimeOfDay  time2;
  ShareServiceProductHelper page=null;
  Widget value;
  List _service = [ServiceTypeController.medicine, ServiceTypeController.vehicle, ServiceTypeController.food
                    , ServiceTypeController.book,ServiceTypeController.parking,ServiceTypeController.houseRent
                     , ServiceTypeController.mechanic,ServiceTypeController.courier,ServiceTypeController.other];

  List<DropdownMenuItem<String>> _dropDownMenuItems;   //_service list will be in _dropDownMenuItems
  static String currentservice="";
  static String username="";
  static String uid="";


  //Google Map related variables
  static GoogleMapController _googleMapController;
  static Map<MarkerId, Marker> serviceMarkers ;
  static GeoPoint _Area;

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }
  void setMarkers(lat,lon)
  {
    Marker marker= Marker(
      markerId: MarkerId("Your Marker"),
      position: LatLng(lat, lon),

    );

    serviceMarkers[MarkerId("Your Marker")]=marker;

  }


  @override
  void initState() {
    //Google Map realated variables instantiated
    serviceMarkers = <MarkerId, Marker>{};



    //getting the username from shared Preference
    SharedPreferenceHelper.readfromlocalstorage().then((user){
      setState((){
        //username = user.getusername();
        //uid=user.getuid();
        username="Sajid576";
        uid="weqwe2131232ewqedsa";
        _UserName.text=username;

      });
    });
    _dropDownMenuItems = getDropDownMenuItems();
    currentservice = _dropDownMenuItems[0].value;


    ShareServiceProductHelper object = new ShareServiceProductHelper();
    value = object.medicineLayout();

    //image setstate

    ShareServiceProductHelper.streamController.stream.listen((data) {
      //second time ui will be load
      if(page!=null){
        print("DataReceived: " + data);
        changedDropDownItem(currentservice);
      }


    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });

    //radio setstate

    ShareServiceProductHelper.BookTYpeController.stream.listen((data){
      //print("listener");
      //radio clicking than the ui will be changed
      if(page!=null){
        //print("DataReceived: " + data);
        changedDropDownItem(currentservice);
      }
    });


    super.initState();
  }

  //dropdown er kaz........

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String service in _service) {
      items.add(new DropdownMenuItem(
          value: service,
          child: new Text(service)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {

    theme = Theme.of(context);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Share Your Service"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:  SingleChildScrollView(

              child: Column(
                children:<Widget>[

                  Center(

                    child: Container(
                        margin: EdgeInsets.only(left: 0,right:0,top:30,bottom: 30),
                        child: Text("Please Select a Service You Want to Share",style: TextStyle(fontSize: 18),)),
                  ),

                  //dropodown shown....

                  Center(
                    child: DropdownButton(
                      value: currentservice,
                      items:_dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                  ),
                  SizedBox(height: 10,),

                  //username....

                  Container(
                    padding: EdgeInsets.only(left: 17,right:17),
                    //color: Colors.grey.withOpacity(0.5),
                    child: Card(
                      child: Theme(
                        data: theme.copyWith(primaryColor: Colors.deepPurple),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[200])),
                              icon: Icon(Icons.person, color: Colors.deepPurple,),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[300])),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "User Name"),
                          controller: _UserName,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  //Container for holding Google Map
                   Container(
                      width: double.infinity,
                      height: 200,
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
                          target: LatLng(GoogleMapView.userLatitutde,GoogleMapView.userLongitude),
                          zoom: 17,
                        ),
                        markers: Set<Marker>.of(serviceMarkers.values),
                        onMapCreated: _onMapCreated,
                        onCameraMove: (CameraPosition position) {

                            print("lat: " + position.target.latitude.toString() + " lon: " + position.target.longitude.toString());
                            _Area = GeoPoint(position.target.latitude, position.target.longitude);


                            GeoCoder.geoCoding(_Area.latitude,_Area.longitude).then((address){
                              print("Adress:  "+address);
                              //this text widget will be  changed when marker of the google map will be changed
                              _addressEditingController.text=address;


                            });


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


                        },
                      ),
                    ),

                  RaisedButton(
                      color:  Colors.black87,
                      onPressed: () {

                        UserBackgroundLocation.getCurrentLocationUpdates();

                        if (_googleMapController != null)
                        {

                          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                              bearing: 192.8334901395799,
                              target: LatLng(GoogleMapView.userLatitutde,GoogleMapView.userLongitude),
                              tilt: 30,
                              zoom: 18.00)));

                        }
                        setMarkers(GoogleMapView.userLatitutde,GoogleMapView.userLongitude);

                      },
                      child: Text("Track Yourself" ,style: TextStyle(color: Colors.white),),

                    ),


                  SizedBox(
                    height: 8,
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 17,right:17),
                    //color: Colors.grey.withOpacity(0.5),
                    child: Card(
                      child: Theme(
                        data: theme.copyWith(primaryColor: Colors.deepPurple),
                        child: TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[200])),
                              icon: Icon(Icons.home,
                                color: Colors.deepPurple,),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[300])),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "address"),
                          controller: _addressEditingController,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: Text("Enter your available time",style: TextStyle(fontSize: 20),)),

                  //Time picker.....

                  Container(
                    padding: EdgeInsets.only(left: 15,right:15),
                    child: Card(
                      child: Theme(
                        data: theme.copyWith(primaryColor: Colors.deepPurple),

                        child:DateTimeField(
                          decoration:  InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[200])),
                              icon: Icon(Icons.timer,
                                color: Colors.deepPurple,),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[300])),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "Starting Time"),
                          format: DateFormat("HH:mm"),
                          onShowPicker: (context, currentValue) async {
                            time1 = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.convert(time1);
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15,right:15),
                    child: Card(
                      child: Theme(
                        data: theme.copyWith(primaryColor: Colors.deepPurple),
                        child: DateTimeField(
                          decoration:  InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[200])),
                                     icon: Icon(Icons.timer_off, color: Colors.deepPurple,),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[300])),
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: "Ending Time"),
                          //inputType: InputType.time,
                          format: DateFormat("HH:mm"),
                          onShowPicker: (context, currentValue) async {
                            time2 = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.convert(time2);
                          },
                        ),
                      ),
                    ),
                  ),

                  Container(

                    child: value,
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0, bottom: 50),
                    child: Center(
                      child: RaisedButton(
                        child: Text("Save"),
                        color:  Colors.black,
                        onPressed: (){
                          final address = _addressEditingController.text.trim();
                          final time=DateTimeField.convert(time1).hour.toString()+":"+DateTimeField.convert(time1).minute.toString()+"-"+DateTimeField.convert(time2).hour.toString()+":"+DateTimeField.convert(time2).minute.toString();
                          print(time.toString()+","+address);
                          setState(() {

                            ShareYourServiceController.requestSendDataToFirebase(uid,currentservice,address,time);
                          });
                        },
                        textColor: Colors.yellow,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey,
                      ),
                    ),
                  )


                ],

              ),



    ),
    );
  }
  void changedDropDownItem(String selectedservice){
    if(page==null){
      page = new ShareServiceProductHelper();  //for the first time page object is created

    }
    setState(() {
      currentservice=selectedservice;
      if(currentservice==ServiceTypeController.medicine){

        value = page.medicineLayout();           //giving medicine widget
      }
      else if(currentservice==ServiceTypeController.vehicle){
        value = page.vehicleshareing();           //giving vehicle widget
      }
      else if(currentservice==ServiceTypeController.food){
        value = page.Food_Grocery_Fruit();          //giving Food/Grocery/Fruit item Sharing widget
      }
      else if(currentservice==ServiceTypeController.book){
        value = page.book_sharing();                 //giving medicine widget
      }
      else if(currentservice==ServiceTypeController.parking){
        value = page.parking_sharing();               //giving Parking widget
      }
      else if(currentservice==ServiceTypeController.houseRent){
        value = page.house_rent();                      //giving House rent widget
      }
      else if(currentservice==ServiceTypeController.mechanic){
        value = page.mechanic_service();                  //giving Mechanic service widget
      }
      else if(currentservice==ServiceTypeController.courier)
      {
        //implement Courier widget

      }
      else if(currentservice==ServiceTypeController.other)
        {
          //implement Others widget
          value = page.other_services();
        }
    });
  }
}
