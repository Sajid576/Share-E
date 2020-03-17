import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = getPosts();//for the very first time it loads up all the data from fireStore
  }
  navigateToDetailPage(DocumentSnapshot sharedServices){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(sharedServices: sharedServices,)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //bringing data from cloud fireStore through 'FutureBuilder'
      child: FutureBuilder(
        future:_data,//getting documents of shared_services
        builder:(_, snapshot){ //snapshot has all the array data
          //if it's not yet come from fireBase
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Text("Loading..."),
            );
          }else{
             return ListView.builder(
               itemCount: snapshot.data.length,//shared_service document array size
                 itemBuilder:(_, index){
                   return ListTile(
                     title:Text(snapshot.data[index].data["service_product_type"]),
                     subtitle: Text(snapshot.data[index].data["username"]),
                     onTap: () =>navigateToDetailPage(snapshot.data[index]),//passing all data of the document
                   );
                 }
             );
          }
        }
      )
    );
  }
}
class DetailPage extends StatefulWidget {
  final DocumentSnapshot sharedServices;
  DetailPage({this.sharedServices});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sharedServices.data["service_product_type"]),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.sharedServices.data["service_product_name"]),
            subtitle: Text(widget.sharedServices.data["available_time"]),
          ),
        ),
      ),
    );
  }
}


