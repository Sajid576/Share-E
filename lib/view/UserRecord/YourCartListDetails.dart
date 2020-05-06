import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/AuxilaryClasshelper/GeoCoder.dart';
import 'package:share_e/Controller/LeftNavigationDrawyer.dart';
class YourCartListDetails extends StatefulWidget {
  final DocumentSnapshot SharedService;

  YourCartListDetails({this.SharedService});

  @override
  _YourCartListDetailsState createState() => _YourCartListDetailsState();
}

class _YourCartListDetailsState extends State<YourCartListDetails>  with SingleTickerProviderStateMixin{
  String username="";
  String phn="";
  String serviceName="";
  String price="";
  String availableTime="";
  String serviceId="";
  GeoPoint geo;
  String address="";

  double mapHeight=200.0;
  static Map<MarkerId, Marker> serviceMarkers ;
  static GoogleMapController _googleMapController;

  LeftNavDrawyer leftnavState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Google Map realated variables instantiated
    serviceMarkers = <MarkerId, Marker>{};

    //instantiating left Navigation drawyer Object
    AnimationController controller=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(controller);

    serviceName= widget.SharedService.data["service_product_name"];
    price= widget.SharedService.data["price"];
    availableTime= widget.SharedService.data["available_time"];
    serviceId= widget.SharedService.data["service_id"];
    geo=widget.SharedService.data["area"];
    GeoCoder.geoCoding(geo.latitude,geo.longitude).then((address){
      setState(() {
        this.address=address;
        print("Address:  "+address);
      });

    });   //retuns address in form of string
    //setting marker on google map
    setMarkers(geo.latitude,geo.longitude);

    String userUid =widget.SharedService.data["uid"];
    readUserData(userUid);
  }
  Future<void>readUserData(useruid)async{
    var userquery = await Firestore.instance.collection("users").document(useruid);
    userquery.get().then((datasnapshot){
      setState(() {
        username = datasnapshot.data["username"];
        phn = datasnapshot.data["Phone"];
      });

      print("username "+username+"Phone no "+phn);
    });
  }

  //this method used for dynamically fetching image URL ,set them on a list of widgets
  List<Widget> CaroselImageGenarator()
  {
    String Images=widget.SharedService.data["images"];
    List<String>imageUrl;

    List imageWidgets;
    if(Images!=null)
    {
      Images=Images.trim();
      imageUrl= Images.split(",");

      print("length:  "+imageUrl.length.toString());
      imageWidgets = new List<Widget>();
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
        title: Text(widget.SharedService.data["service_product_type"]),
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
            SizedBox(height: 20,),

            //*********information about the USER*******
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


            //*********************** Information about the Service ***************
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



                ],
              ),
            ),
            

            



          ],
        ),
      ) ,
    );
  }
}
