import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/LeftNavigationDrawyer.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'YourCartListDetails.dart';

class YourCartList extends StatefulWidget {
  @override
  _YourCartListState createState() => _YourCartListState();
}

class _YourCartListState extends State<YourCartList> with SingleTickerProviderStateMixin{
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
      var _uid = 'ExzHS3WoxAZjiGzRLV7xFS0zgsS2';
      print("Current User"+_uid);

       getPosts(_uid);//for the very first time it loads up all the data from fireStore

    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();

  }

  Future getPosts(_uid)async{

    var query = await Firestore.instance.collection("Cart").document(_uid);
    // print("Getpost "+_uid);
    List<dynamic> docs=new List<dynamic>();

    query.get().then((snapshot) async{

      //service uid  will be in values
      List<String>values=List.from(snapshot.data["Service_list"]);
      print("Values "+values.toString());
      for(var i=0;i<values.length;i++){
        await Firestore.instance.collection("Shared_Services").document(values[i]).get().then((query){
          docs.add(query);
        });
      }

      print("doc size"+docs.length.toString());
      _streamController.add(docs);

    });



  }
  navigateToDetailPage(DocumentSnapshot SharedService){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>YourCartListDetails(SharedService: SharedService,)));
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart List"),
        backgroundColor: Colors.grey[800],
      ),
      body: SafeArea(
        child: Container(
            color: Colors.grey[400],
            //bringing data from cloud fireStore through 'FutureBuilder'
            child: StreamBuilder(

                stream:_streamController.stream ,//getting documents of shared_services
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
                              imageUrl:imageUrl[0],
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            title:Text(snapshot.data[index].data["service_product_type"]),
                            subtitle: Text(snapshot.data[index].data["uid"]),
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
    );
  }
}