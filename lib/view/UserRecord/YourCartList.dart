import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/LeftNavigationDrawyer.dart';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'YourCartListDetails.dart';
import 'package:share_e/Controller/YourStreamController.dart';

class YourCartList extends StatefulWidget {
  @override
  _YourCartListState createState() => _YourCartListState();
}

class _YourCartListState extends State<YourCartList> with SingleTickerProviderStateMixin{

  LeftNavDrawyer leftnavState;
  @override
  void initState() {         //only runs when the activity load at the very begging
    // TODO: implement initState
    super.initState();
    //instantiating left Navigation drawyer Object
    AnimationController controller=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(controller);


    SharedPreferenceHelper.readfromlocalstorage().then((user) { //Reading from local storage it needs some time

      //_profile_username = user.getusername();
      //_uid= user.getid();
      var _uid = 'ExzHS3WoxAZjiGzRLV7xFS0zgsS2';
      print("Current User"+_uid);

      //fetch all Cart data from firestore
      FirebaseService().getCartList(_uid);

    });
  }

  @override
  void dispose() {
    super.dispose();
    leftnavState.controller.dispose();

  }


  navigateToDetailPage(DocumentSnapshot SharedService){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>YourCartListDetails(SharedService: SharedService,)));
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[

          leftnavState.leftNavLayout(context),
          YourCartlist(context),
        ],
      ),
    );
  }
  Widget YourCartlist(context){
    return AnimatedPositioned(
      duration: LeftNavDrawyer.duration,
      top: 0,            //scale is done for top and bottom
      bottom: 0,
      left: leftnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width ,
      right:leftnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width,
      child: ScaleTransition(
        scale: LeftNavDrawyer.leftEnabled==true ? leftnavState.scaleAnimation : leftnavState.scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.white,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Your Cart List"),
              leading: GestureDetector(
                //onHorizontalDragEnd: (DragEndDetails details)=>_onHorizontalDrag(details),
                onTap: (){
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
                child: Icon(
                  Icons.menu,color: Colors.black,size: 35,  // add custom icons also
                ),
              ),
            ),
            body: ListView(
              children: <Widget>[
                SafeArea(
                  child: Container(
                      color: Colors.grey[400],
                      //bringing data from cloud fireStore through 'FutureBuilder'
                      child: StreamBuilder(

                          stream:YourStreamController.CartListstreamController.stream ,
                          builder:(_, snapshot){ //snapshot has all the array data
                            //if it's not yet come from fireBase
                            if(!snapshot.hasData){
                              return Center(
                                child: Text("Loading..."),
                              );
                            }else{
                              return ListView.separated(
                                itemCount: snapshot.data.length,//shared_service document array size
                                itemBuilder:(BuildContext context,int index){
                                  String images=snapshot.data[index].data["images"];
                                  List<String>imageUrl;
                                  if(images!=null)
                                  {
                                    images=images.trim();
                                    imageUrl= images.split(",");
                                  }

                                  return Container(
                                    color: Colors.white,
                                    child: ListTile(

                                      leading: CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        imageUrl:imageUrl!=null ? imageUrl[0] : "",
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                      contentPadding: EdgeInsets.all(8),
                                      title:Text(snapshot.data[index].data["service_product_type"]),
                                      subtitle: Text(snapshot.data[index].data["service_product_name"]),
                                      onTap: () =>navigateToDetailPage(snapshot.data[index]),//passing all data of the document to the detail page
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context,int index){
                                  return Divider(
                                    color: Colors.black,
                                  );
                                },
                              );
                            }
                          }
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}