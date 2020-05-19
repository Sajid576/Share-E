import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/AuxilaryClasshelper/GeoCoder.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';


class AllSharedServiceDetail extends StatefulWidget {         //this is for if user tabs any item of the listpage then the detail page will loads up
    final DocumentSnapshot sharedServices;

    AllSharedServiceDetail({this.sharedServices});

    @override
    _AllSharedServiceDetailState createState() => _AllSharedServiceDetailState();
}

class _AllSharedServiceDetailState extends State<AllSharedServiceDetail> {

  String username=""; //otherwise invalid arguments will be shown(only user username will contain null
  String phn="";
  String serviceName="";
  String price="";
  String availableTime="";
  String serviceId="";
  GeoPoint geo;
  String address="";
  List imageWidgets;

  String operatingUserUid="";

  double mapHeight=200.0;
  static Map<MarkerId, Marker> serviceMarkers ;
  static GoogleMapController _googleMapController;

  @override
  void initState() {
        super.initState();
        //Google Map realated variables instantiated
        serviceMarkers = <MarkerId, Marker>{};

        SharedPreferenceHelper.readfromlocalstorage().then((user) { //Reading from local storage it needs some time
          //_uid= user.getid();
          operatingUserUid = 'O13DYw7p94dj3AExf8D7g77rfC72';
          print("Current User"+operatingUserUid);

        });
        imageWidgets=CaroselImageGenarator();
        serviceName= widget.sharedServices.data["service_product_name"];
        price= widget.sharedServices.data["price"];
        availableTime= widget.sharedServices.data["available_time"];
        serviceId= widget.sharedServices.data["service_id"];
        geo=widget.sharedServices.data["geo"];
        address=widget.sharedServices.data["area"];

        //setting marker on google map
        setMarkers(geo.latitude,geo.longitude);

        String ServiceProvicerUid = widget.sharedServices.data["uid"];
        print(ServiceProvicerUid);
        readUserData(ServiceProvicerUid.trim());
  }

  Future<void>readUserData(uid)async{
    var query = await Firestore.instance.collection('users').document(uid);

    query.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {

              username = datasnapshot.data['username'];
              phn = datasnapshot.data['phone'];
        });

      }
      else{
              print("No such user");
      }

    });
  }

  //this method used for dynamically fetching image URL ,set them on a list of widgets
  List<Widget> CaroselImageGenarator()
  {
    String Images=widget.sharedServices.data["images"];
    List<String>imageUrls;
    List imageWidgets;
    if(Images!=null)
    {
      Images=Images.trim();
      imageUrls= Images.split(";");

      print("length:  "+imageUrls.length.toString());

      imageWidgets = new List<Widget>();
      for(var i=0;i<imageUrls.length;i++)
      {
        if(imageUrls[i].isNotEmpty) {
          imageWidgets.add(
            CachedNetworkImage(
              imageUrl: imageUrls[i],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        }
      }
    }


    return imageWidgets;

  }

  void setMarkers(lat,lon)
  {
    Marker marker= Marker(
      markerId: MarkerId("Service Marker"),
      position: LatLng(geo.latitude,geo.longitude),

    );

    serviceMarkers[MarkerId("Your Marker")]=marker;

  }
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sharedServices.data["service_product_type"]),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //slide showing
            Center(
              child: SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Carousel(                     //Carousel image showing
                    images: imageWidgets ,

                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.black.withOpacity(0.5),
                    borderRadius: true,
                  )
              ),
            ),
            SizedBox(height: 10,),
            //information about the service
            Container(
              margin: const EdgeInsets.only(top:20.0 ,left: 20.0, right: 20.0),
              color: Colors.white.withOpacity(1.0),
              width: double.infinity,
              child: Column(

                children: <Widget>[
                    Row(
                      children: <Widget>[
                            CircleAvatar(

                                    radius: 35,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.person,
                                    ),
                                  ),
                             Container(
                               margin: const EdgeInsets.only(left: 20.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                        Text(username ,style: TextStyle(
                                   fontSize: 20,fontWeight: FontWeight.bold ), ),
                                        Text(phn ,style: TextStyle(
                                            fontSize: 20,fontWeight: FontWeight.bold ), ),
                                    ],
                                 ),
                             ),
                       ],
                    ),
                  SizedBox(width: 50,),
                  Center(
                    child: RaisedButton(
                     child: Text("Chat"),
                     color: Colors.black,
                     onPressed: () {
                       //navigate to the particular User's inbox


                     },
                     textColor: Colors.white,
                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     splashColor: Colors.grey,
                              ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Product Name : ",style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20,),
                  Text(serviceName,style: TextStyle(
                      fontSize: 18,
                  ),),
                  SizedBox(height: 20,),
                  Text("price : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), ),
                  SizedBox(height: 20,),
                  Text(price,style: TextStyle(
                      fontSize: 18,
                  ),),
                  SizedBox(height: 20,),

                  Text("Available Time : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text(availableTime,style: TextStyle(
                      fontSize: 18,
                  ),),
                  SizedBox(height: 20,),

                  Text("Service id : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text(serviceId,style: TextStyle(
                      fontSize: 18,
                  ),),
                  SizedBox(height: 20,),
                  Text("Address : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text(address,style: TextStyle(
                      fontSize: 18,
                  ),),
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
                        target: LatLng(geo.latitude, geo.longitude),
                        zoom: 17,
                      ),
                      markers: Set<Marker>.of(serviceMarkers.values),
                      onMapCreated: _onMapCreated,

                    ),

                  ),


                  SizedBox(height: 40,),
                  Center(
                    child: RaisedButton(
                      
                      child: Text("Add to Cart"),
                      color: Colors.black,
                      onPressed: () {
                        FirebaseService.AddToCart(operatingUserUid, serviceId);

                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      splashColor: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),

          ],
        ),
      ) ,
    );
  }
}


