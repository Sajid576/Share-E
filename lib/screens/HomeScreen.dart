import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with SingleTickerProviderStateMixin {
  bool isCollapsed = true; //at the begining it is collapsed that means only home is showing 100%
  double screenheight, screenwidth;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;

 // _controller,_scaleAnimation these for top and bottom so that they don't have overflow condition

  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: duration);
    _scaleAnimation=Tween<double>(begin: 1,end: 0.6).animate(_controller);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: <Widget>[
              menu(context),
              dashboard(context),
            ],
          ),
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Text("Home"),
            centerTitle: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.map),),
                Tab(icon: Icon(Icons.list),),
              ],
            ),
          ),
        ),
      ),

    );
  }

  //side bar e ki ki option thakbe ta menu te ache

  Widget menu(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Profile",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "ShareService",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "Account",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  // dashboard is for home page

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,            //scale is done for top and bottom
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenwidth,
      right: isCollapsed ? 0 : -0.4 * screenwidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SafeArea(
            child: Column(
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
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                /*TabBar(
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.map),),
                    Tab(icon: Icon(Icons.list),),
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
