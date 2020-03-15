import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/view/CustomMarker.dart';
import 'package:share_e/view/GoogleMapView.dart';
import 'package:share_e/view/ProfileScreen.dart';
import 'package:share_e/view/LoginScreen.dart';
import 'package:background_location/background_location.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:swipedetector/swipedetector.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  bool isCollapsed = true; //at the begining it is collapsed that means only home is showing 100%

  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;


 // _controller,_scaleAnimation these for top and bottom so that they don't have overflow condition

  @override
  void initState() {
    super.initState();

    //when user is in home page, the device location will start to be tracked
    BackgroundLocation.startLocationService();
    getCurrentLocationUpdates();

    //these code for homePage layout animation
    _controller=AnimationController(vsync: this,duration: duration);
    _scaleAnimation=Tween<double>(begin: 1,end: 0.6).animate(_controller);
    //these tow for menu animation
    _menuScaleAnimation = Tween<double>(begin: 0.5,end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0)).animate(_controller);
  }
  @override
  void dispose() {
    //When user gets out of this Screen location tracking interface will be disabled
    //code for disabling
    BackgroundLocation.stopLocationService();


    //this controller is for animating navigation drawyer
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
              backgroundColor: backgroundColor,
              body: Stack(
                children: <Widget>[
                  leftMenu(context),
                  HomeLayout(context),
                ],
              ),

            );


  }


  //side bar e ki ki option thakbe ta menu te ache

  Widget leftMenu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child:Text(
                    "Home",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ));
                  },

                ),

                SizedBox(
                  height: 18,
                ),
                FlatButton(
                  child:Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ProfileScreen(),
                        ));
                  },

                ),

                SizedBox(
                  height: 18,
                ),
                FlatButton(
                  child:Text(
                    "Share Service",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                    onPressed: () {

                    }
                ),
                FlatButton(
                  child:Text(
                    "Your Shared Service",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                    onPressed: () {

                    }
                ),
                FlatButton(
                  child:Text(
                    "Your Received Service",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                    onPressed: () {

                    }
                ),
                FlatButton(
                  child:Text(
                    "Account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                    onPressed: () {

                    }
                ),
                SizedBox(
                  height: 18,
                ),

                FlatButton(
                  child:Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    //this logout() used for erasing the session
                    SharedPreferenceHelper.logout();

                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ));
                  },
                ),

                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Homelayout is for home page

  Widget HomeLayout(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,            //scale is done for top and bottom
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width,
      right: isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SafeArea(
            child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.white),
                          onTap: () {
                            setState(() {
                              if(isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();
                              isCollapsed =
                                  !isCollapsed; //just reversing it to false
                            });
                          },
                        ),
                        /*Text(
                          "Home",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),*/

                      ],
                    ),
                  ),
                  Container(
                    child:TabBar(
                      tabs: <Widget>[
                        Tab(icon: Icon(Icons.map),),
                        Tab(icon: Icon(Icons.list),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      //here body of all tab layouts will be called
                      children: [
                        //tab for google map with device location tracker
                        new GoogleMapView().googleMapLayout(context),
                        //tab for listview builder  will be implemented later
                        Icon(Icons.list),

                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  

   void updateMarkerAndCircle(var lat,var lon,var accuracy,var bearing) {
    LatLng latlng = LatLng(lat, lon);

  setState(() {
    GoogleMapView.marker = Marker(
        markerId: MarkerId("user"),
        position: latlng,
        rotation: bearing,    //not sure about this rotation parameter
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
          );
    GoogleMapView.circle = Circle(
        circleId: CircleId("user"),
        radius: accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latlng,
        fillColor: Colors.blue.withAlpha(30));


  });
  }

  void getCurrentLocationUpdates() async {




    BackgroundLocation.getLocationUpdates((location) {
      var latitude = location.latitude;
      var longitude = location.longitude;
      var accuracy = location.accuracy;
      var bearing = location.bearing;
      print("latitude:  "+latitude.toString() +"  longitude: "+longitude.toString());
      
      var googleMapController=new GoogleMapView().get_googleMapController();
      if (googleMapController != null)
      {
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(latitude, longitude),
            tilt: 0,
            zoom: 18.00)));
        updateMarkerAndCircle(latitude,longitude,accuracy,bearing);
      }
    });

  }


}
