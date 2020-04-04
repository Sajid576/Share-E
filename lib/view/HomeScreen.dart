import 'package:flutter/material.dart';
import 'package:share_e/view/GoogleMapView.dart';
import 'package:share_e/view/ProfileScreen.dart';
import 'package:share_e/view/LoginScreen.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/AuxilaryClasshelper/UserBackgroundLocation.dart';
import 'package:share_e/view/AllSharedServices.dart';
import 'package:share_e/Controller/FutureHolder.dart';
import 'package:share_e/view/YourCartList.dart';
import 'package:share_e/view/YourReceivedSharedService.dart';
import 'package:share_e/view/YourSharedService.dart';

final Color backgroundColor = Colors.white;

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
  Color selectedBackgroundColor =Colors.white;
  // _controller,_scaleAnimation these for top and bottom so that they don't have overflow condition


  GoogleMapView googleMapView;


  @override
  void initState() {
    super.initState();
    //initializing the google map interface with initial location and markers
    googleMapView= new GoogleMapView.init(true);

    FutureHolder futureHolder=new FutureHolder();
    futureHolder.requestAllSharedService();


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


    //these code for homePage layout animation
    _controller=AnimationController(vsync: this,duration: duration);
    _scaleAnimation=Tween<double>(begin: 1,end: 0.6).animate(_controller);
    //these tow for menu animation
    _menuScaleAnimation = Tween<double>(begin: 0.5,end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0)).animate(_controller);
  }


  @override
  void dispose() {
    super.dispose();
    //When user gets out of this Screen location tracking interface will be disabled
    //code for disabling
    new UserBackgroundLocation().stopLocationService();

    //closing the stream controller to prevent performance dropout
    GoogleMapView.locationTrackingController.close();
    GoogleMapView.searchBoxParameterController.close();

    //this controller is for animating navigation drawyer
    _controller.dispose();


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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                  ),
                  FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Home",
                      style: TextStyle(color: Colors.black, fontSize: 18),
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
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Profile",
                      style: TextStyle(color:  Colors.black, fontSize: 18),
                    ),
                    onPressed: () {

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
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "Share Service",
                        style: TextStyle(color:  Colors.black, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ProfileScreen(),
                            ));
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "Your Shared Service",
                        style: TextStyle(color:  Colors.black, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => YourSharedService(),
                            ));
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "Your Received Service",
                        style: TextStyle(color:  Colors.black, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => YourReceivedSharedService(),
                            ));
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "Your Cart Services",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => YourCartList(),
                            ));
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "Your Requisite Services",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onPressed: () {

                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "All Requisite Services",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onPressed: () {

                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Text(
                        "Account",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onPressed: () {

                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),

                  FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Text(
                      "Logout",
                      style: TextStyle(color: Colors.black, fontSize: 18),
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
      ),
    );
  }

  // Homelayout is for home page

  Widget HomeLayout(context) {
    GoogleMapView.context=context;

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

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.black,size: 35,),
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
                          Text("Share-E",style: TextStyle(color: Colors.black, fontSize: 25,),
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
                        AllSharedServices().AllSharedServiceslayout(context),
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
