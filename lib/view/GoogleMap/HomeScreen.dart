import 'package:flutter/material.dart';
import 'package:share_e/Controller/LeftNavigationDrawyer.dart';
import 'package:share_e/Controller/RightNavigationDrawyer.dart';
import 'package:share_e/view/GoogleMap/AllSharedServices.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/GoogleMap/GoogleMapView.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/UserInfo/ProfileScreen.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/Authentication/LoginScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';

import 'package:share_e/Controller/GetAllSharedServiceController.dart';
import 'package:share_e/view/UserRecord/YourReceivedService.dart';
import 'file:///D:/Flutter_Projects/ShareE_master/Share-E/lib/view/UserRecord/YourCartList.dart';
import 'package:share_e/view/UserRecord/YourSharedService.dart';


final Color backgroundColor = Colors.white;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin{
  GoogleMapView googleMapView;
  LeftNavDrawyer leftnavState;
  RightNavDrawyer rightnavState;
  bool leftEnabled=false;
  bool rightEnabled=false;

  @override
  void initState() {
    super.initState();
    //initializing the google map interface with initial location and markers
    googleMapView= new GoogleMapView.init(true);

    //instantiating left Navigation drawyer Object
    AnimationController leftController=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(leftController);

    //instantiating right Navigation drawyer object
    AnimationController rightController=AnimationController(vsync:this ,duration: RightNavDrawyer.duration);
    rightnavState=RightNavDrawyer(rightController);

    //this function will keep updating the UI of google map on changed location
    GoogleMapView.locationTrackingController.stream.listen((isTrackOn) {
            print("isTrackON:  "+isTrackOn.toString());
            setState(() {
            });
        });
    GoogleMapView.searchBoxParameterController.stream.listen((searchType) {
      print("SearchTypeSet:  "+searchType.toString());
      setState(() {
      });
    });


    //ServiceMarkerIcon markerIcon=new ServiceMarkerIcon();
    //markerIcon.getMarkerIcon(service_name);
    //googleMapView.setMarker(id, lat, lon, title, snippet, _markerIcon)

  }


  @override
  void dispose() {
    super.dispose();
    //When user gets out of this Screen location tracking interface will be disabled
    //code for disabling
    new UserBackgroundLocation().stopLocationService();

    //closing the stream controller to prevent performance dropout
    //GoogleMapView.locationTrackingController.close();
    //GoogleMapView.searchBoxParameterController.close();
    //GetAllSharedServiceController.AllServicedataController.close();


    leftnavState.controller.dispose();
    rightnavState.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          rightnavState.rightNavLayout(context),
          leftnavState.leftNavLayout(context),
          HomeLayout(context),
        ],
      ),

    );


  }

  // Homelayout is for home page

  Widget HomeLayout(context) {
    GoogleMapView.context=context;

    return AnimatedPositioned(
      duration: LeftNavDrawyer.duration,
      top: 0,            //scale is done for top and bottom
      bottom: 0,
      left:rightEnabled==true ?  rightnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width : leftEnabled==true?  leftnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width : 0,
      right:rightEnabled==true ? rightnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width : leftEnabled==true? leftnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width : 0,
      child: ScaleTransition(
        scale:rightEnabled==true ? rightnavState.scaleAnimation : leftEnabled==true ? leftnavState.scaleAnimation : leftnavState.scaleAnimation,
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
                          child: Icon(Icons.menu, color: Colors.black,size: 35,),
                          onTap: () {

                            setState(() {
                              if(leftnavState.isCollapsed)
                               {
                                  leftnavState.controller.forward();
                               }
                              else
                                {
                                  leftnavState.controller.reverse();
                                }
                              leftEnabled=!leftEnabled;
                              leftnavState.isCollapsed = !leftnavState.isCollapsed;
                                 //just reversing it to false
                            });
                          },
                        ),
                        Center(
                            child: Text("Share-E",style: TextStyle(color: Colors.black, fontSize: 25,),),
                          ),
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.black,size: 35,),
                          onTap: () {

                            setState(() {
                              if(rightnavState.isCollapsed)
                              {
                                rightnavState.controller.forward();
                              }
                              else
                              {
                                rightnavState.controller.reverse();
                              }
                              rightEnabled=!rightEnabled;
                              rightnavState.isCollapsed = !rightnavState.isCollapsed;
                              //just reversing it to false
                            });
                          },
                        ),

                      ],
                    ),
                  ),
                  Container(
                    child:TabBar(
                      tabs: <Widget>[
                        Tab(icon: Icon(Icons.map,color: Colors.black,),  ),
                        Tab(icon: Icon(Icons.list ,color: Colors.black,),),
                      ],
                    ),
                  ),
                  Expanded(

                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      //here body of all tab layouts will be called
                      children: [
                        //tab for google map with device location tracker
                        googleMapView.googleMapLayout(),

                       //tab for listview builder  will be implemented later
                        AllSharedServices(),
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







}
