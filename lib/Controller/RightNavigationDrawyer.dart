import 'package:flutter/material.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';
import 'package:share_e/Controller/ServiceTypeController.dart';

class RightNavDrawyer
{
  static Duration duration = const Duration(milliseconds: 300);
  AnimationController controller;
  bool isCollapsed = true; //at the begining it is collapsed that means only home is showing 100%
  Animation<double> scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Color selectedBackgroundColor =Colors.white;

  RightNavDrawyer rightNavDrawyer;
  static bool rightEnabled=false;
  setNavDrawyerObject(rightNavDrawyer)
  {
      this.rightNavDrawyer=rightNavDrawyer;
  }
  RightNavDrawyer(control){

    //these code for homePage layout animation
    this.controller=control;
    scaleAnimation=Tween<double>(begin: 1,end: 0.6).animate(controller);
    //these tow for menu animation
    _menuScaleAnimation = Tween<double>(begin: 0.5,end: 1).animate(controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0)).animate(controller);

  }

  Widget rightNavLayout(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  FlatButton(

                    disabledColor: selectedBackgroundColor,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:<Widget>[
                        Icon(Icons.healing),
                        Text(
                          "All Shared Services",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(!rightNavDrawyer.isCollapsed)
                      {
                        rightNavDrawyer.controller.reverse();
                        rightEnabled=!rightEnabled;
                        rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                      }
                      GetAllSharedServiceController.requestAllSharedService();

                    },

                  ),
                  SizedBox(
                    height: 18,
                  ),

                  FlatButton(

                    disabledColor: selectedBackgroundColor,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:<Widget>[
                        Icon(Icons.healing),
                        Text(
                          "Shared Medicine",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(!rightNavDrawyer.isCollapsed)
                      {
                        rightNavDrawyer.controller.reverse();
                        rightEnabled=!rightEnabled;
                        rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                      }
                      GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.medicine);

                    },

                  ),

                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                    disabledColor: selectedBackgroundColor,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:<Widget>[
                        Icon(Icons.book),
                        Text(
                          "Shared Books",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(!rightNavDrawyer.isCollapsed)
                      {
                        rightNavDrawyer.controller.reverse();
                        rightEnabled=!rightEnabled;
                        rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                      }
                      GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.book);

                    },

                  ),

                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Icon(Icons.gavel),
                          Text(
                            "Mechanic/Electrician",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(!rightNavDrawyer.isCollapsed)
                        {
                          rightNavDrawyer.controller.reverse();
                          rightEnabled=!rightEnabled;
                          rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                        }
                        GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.mechanic);
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Icon(Icons.directions_car),
                          Text(
                            "Shared Vehicle",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(!rightNavDrawyer.isCollapsed)
                        {
                          rightNavDrawyer.controller.reverse();
                          rightEnabled=!rightEnabled;
                          rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                        }
                        GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.vehicle);
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Icon(Icons.fastfood),
                          Text(
                            "Shared Food/Grocery",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(!rightNavDrawyer.isCollapsed)
                        {
                          rightNavDrawyer.controller.reverse();
                          rightEnabled=!rightEnabled;
                          rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                        }
                        GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.food);
                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Icon(Icons.home),
                          Text(
                            "House Rent",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(!rightNavDrawyer.isCollapsed)
                        {
                          rightNavDrawyer.controller.reverse();
                          rightEnabled=!rightEnabled;
                          rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                        }
                        GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.houseRent);

                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Icon(Icons.local_parking),
                          Text(
                            "Shared Parking",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(!rightNavDrawyer.isCollapsed)
                        {
                          rightNavDrawyer.controller.reverse();
                          rightEnabled=!rightEnabled;
                          rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                        }
                        GetAllSharedServiceController.requestFilterByServiceType(ServiceTypeController.parking);

                      }
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  FlatButton(
                      disabledColor: selectedBackgroundColor,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget>[
                          Icon(Icons.transfer_within_a_station),
                          Text(
                            "Shared Courier",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(!rightNavDrawyer.isCollapsed)
                        {
                          rightNavDrawyer.controller.reverse();
                          rightEnabled=!rightEnabled;
                          rightNavDrawyer.isCollapsed = !rightNavDrawyer.isCollapsed;
                        }


                      }
                  ),
                  SizedBox(
                    height: 18,
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

}