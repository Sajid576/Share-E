import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/YourSharedServiceDetails.dart';
class YourSharedService extends StatefulWidget {
  @override
  _YourSharedServiceState createState() => _YourSharedServiceState();
}

class _YourSharedServiceState extends State<YourSharedService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("your Shared Services"),
        backgroundColor: Colors.grey[800],
      ),
      body: YourListPage(),
    );
  }
}
class YourListPage extends StatefulWidget {
  @override
  _YourListPageState createState() => _YourListPageState();
}

class _YourListPageState extends State<YourListPage> {
  Future _data;
  var _uid;

  @override
  void initState() {         //only runs when the activity load at the very begging
    // TODO: implement initState
    super.initState();
    SharedPreferenceHelper.readfromlocalstorage().then((user) { //Reading from local storage it needs some time

      //_profile_username = user.getusername();
      //_uid= user.getid();
      _uid = 'O13DYw7p94dj3AExf8D7g77rfC72';
      print("Current User"+_uid);
      _data = getPosts();//for the very first time it loads up all the data from fireStore

    });


  }
  Future getPosts()async{
    //instantiate FireStore
    //var firestore = Firestore.instance; //giving a FireBase instance
    QuerySnapshot qn= await Firestore.instance.collection("Shared_Services").where("uid",isEqualTo: _uid).getDocuments();//accessing shared_services documents
   // print("Getpost "+_uid);
    return qn.documents;  //all the documents array inside the shared_Service
  }
  navigateToDetailPage(DocumentSnapshot YourSharedService){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>YourSharedServiceDetails(Yoursharedservice: YourSharedService,)));
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
        )
    );
  }
}

