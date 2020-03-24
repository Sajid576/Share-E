import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AllServiceDetail.dart';
import 'dart:async';
class ListViewServiceShare extends StatefulWidget {
  @override
  _ListViewServiceShareState createState() => _ListViewServiceShareState();
}

class _ListViewServiceShareState extends State<ListViewServiceShare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Services"),
        backgroundColor: Colors.grey[800],
      ),
      body: ListPage(),
    );
  }
}
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getPosts()async{
    //instantiate FireStore
    var firestore = Firestore.instance; //giving a FireBase instance
    QuerySnapshot qn= await firestore.collection("Shared_Services").getDocuments();//accessing shared_services documents
    return qn.documents;  //all the documents array inside the shared_Service
  }
  @override
  void initState() {         //only runs when the activity load at the very begging
    // TODO: implement initState
    super.initState();
    _data = getPosts();//for the very first time it loads up all the data from fireStore
  }
  navigateToDetailPage(DocumentSnapshot sharedServices){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AllServiceDetail(sharedServices: sharedServices)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[400],
      //bringing data from cloud fireStore through 'FutureBuilder'
      child: FutureBuilder(
        future:_data,//getting documents of shared_services
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
                   return SingleChildScrollView(                          //srollable
                     child: ListTile(
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
      ),
    );
  }
}
