import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/LeftNavigationDrawyer.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/UserRecord/YourSharedServiceDetails.dart';

class YourSharedService extends StatefulWidget {
  @override
  _YourSharedServiceState createState() => _YourSharedServiceState();
}

class _YourSharedServiceState extends State<YourSharedService> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YourListPage(),
    );
  }
}
class YourListPage extends StatefulWidget {
  @override
  _YourListPageState createState() => _YourListPageState();
}

class _YourListPageState extends State<YourListPage> with SingleTickerProviderStateMixin{
  final StreamController<dynamic> _streamController = new StreamController<dynamic>();
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
      var uid = 'O13DYw7p94dj3AExf8D7g77rfC72';
      print("Current User"+uid);
      getPosts(uid);//for the very first time it loads up all the data from fireStore

    });


  }

  @override
  void dispose() {
    super.dispose();
    leftnavState.controller.dispose();
    _streamController.close();

  }
  Future getPosts(uid)async{

    QuerySnapshot qn= await Firestore.instance.collection("Shared_Services").where("uid",isEqualTo: uid).getDocuments();//accessing shared_services documents

    //all the documents array inside the shared_Service
    _streamController.add(qn.documents);

  }
  navigateToDetailPage(DocumentSnapshot YourSharedService){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>YourSharedServiceDetails(Yoursharedservice: YourSharedService,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[

          leftnavState.leftNavLayout(context),
          YourShareservice(context),
        ],
      ),
    );
  }
  Widget YourShareservice(context){
    return AnimatedPositioned(
      duration: LeftNavDrawyer.duration,
      top: 0,            //scale is done for top and bottom
      bottom: 0,
      left: leftnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width ,
      right:leftnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width,
      child: ScaleTransition(
        scale:LeftNavDrawyer.leftEnabled==true ? leftnavState.scaleAnimation : leftnavState.scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.white,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Your Share Service"),
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
                  Icons.menu,color: Colors.black,size: 37,  // add custom icons also
                ),
              ),
            ),
            body: Container(
                color: Colors.grey[400],
                //bringing data from cloud fireStore through 'FutureBuilder'
                child: StreamBuilder(
                    stream:_streamController.stream,//getting documents of shared_services
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

                            return SingleChildScrollView(                          //srollable
                              child: Container(
                                color:Colors.white,
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
        ),
      ),
    );
  }
}

