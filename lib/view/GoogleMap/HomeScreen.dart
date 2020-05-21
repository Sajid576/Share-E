
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_e/Controller/LeftNavigationDrawyer.dart';
import 'package:share_e/Controller/RightNavigationDrawyer.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/GoogleMap/AllSharedServices.dart';
import 'package:share_e/view/GoogleMap/GoogleMapView.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';
import 'package:share_e/Controller/YourStreamController.dart';
import 'package:share_e/view/GoogleMap/ServiceMarkerIcon.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipedetector/swipedetector.dart';


final Color backgroundColor = Colors.white;


class HomeScreen extends StatefulWidget {
  final String authUid;


  HomeScreen(this.authUid);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin{
  GoogleMapView googleMapView;
  LeftNavDrawyer leftnavState;
  RightNavDrawyer rightnavState;






  checkLocalUserData()
  {
    SharedPreferenceHelper.readfromlocalstorage().then((user) {

      //checks if there is any user data in Shared Preference.
      //this session will return false when user uninstall the app after successful sign up.And then user install the
      //app and sign in . So,when there is no user data in local storage we fetch it from cloud firestore.
      if(!user.getsession())
        {
                FirebaseService.readCloudUserData(widget.authUid);
        }


    });
  }
  @override
  void initState() {
    super.initState();

    new ServiceMarkerIcon.init();

    //this function will check user details in SharedPreference.If there there is user data in Shared preference then
    //it wont fetch anything from cloud firestore otherwise it will fetch user data from firestore and store it into
    //SharedPreference.
    checkLocalUserData();


    //initializing the google map interface with initial location and markers
    googleMapView= new GoogleMapView.init(true);


    //this function request for all the Share services that are shared by users
    GetAllSharedServiceController.requestAllSharedService();


    //instantiating left Navigation drawyer Object and Animation controller for this drawyer
    AnimationController leftController=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(leftController);

    //instantiating right Navigation drawyer object and Animation controller for this drawyer
    AnimationController rightController=AnimationController(vsync:this ,duration: RightNavDrawyer.duration);
    rightnavState=RightNavDrawyer(rightController);
    rightnavState.setNavDrawyerObject(rightnavState);



    GetAllSharedServiceController.AllServicedataController.stream.listen((list) {


      list.forEach((doc) {
          Map<dynamic, dynamic> values = 	Map.from(doc.data);

          var serviceId=values["service_id"];
          var serviceProductType=values["service_product_type"];
          var serviceProductName=values["service_product_name"];
          var geo=  values["geo"];
          var lat=geo.latitude;
          var lon=geo.longitude;
          BitmapDescriptor icon=ServiceMarkerIcon.getMarkerIcon(serviceProductType);

          googleMapView.setServiceMarker(serviceId, lat, lon, serviceProductType, serviceProductName,doc,icon);

      });

      YourStreamController.HomeScreenController.add(true);

    });

    //At the first time it will be called after all the data are fetched from firestore
    //this function will keep updating the UI
    YourStreamController.HomeScreenController.stream.listen((value) {
            print("HomeScreen Called");
            setState(() {
            });
        });





  }


  @override
  void dispose() {
    super.dispose();
    //When user gets out of this Screen location tracking interface will be disabled
    //code for disabling
    UserBackgroundLocation.stopLocationService();

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
      left:RightNavDrawyer.rightEnabled==true ?  rightnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width : LeftNavDrawyer.leftEnabled==true?  leftnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width : 0,
      right:RightNavDrawyer.rightEnabled==true ? rightnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width : LeftNavDrawyer.leftEnabled==true? leftnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width : 0,
      child: ScaleTransition(
        scale:RightNavDrawyer.rightEnabled==true ? rightnavState.scaleAnimation : LeftNavDrawyer.leftEnabled==true ? leftnavState.scaleAnimation : leftnavState.scaleAnimation,
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
                              LeftNavDrawyer.leftEnabled=!LeftNavDrawyer.leftEnabled;
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
                              RightNavDrawyer.rightEnabled=!RightNavDrawyer.rightEnabled;
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
