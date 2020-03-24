import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'package:share_e/view/YourReceivedServiceDetails.dart';

class YourReceivedSharedService extends StatefulWidget {
  @override
  _YourReceivedSharedServiceState createState() => _YourReceivedSharedServiceState();
}

class _YourReceivedSharedServiceState extends State<YourReceivedSharedService>{
  Future _data;
  var _uid;


  @override
  void initState() {         //only runs when the activity load at the very begging
    // TODO: implement initState
    super.initState();
    SharedPreferenceHelper.readfromlocalstorage().then((user) { //Reading from local storage it needs some time

      //_profile_username = user.getusername();
      //_uid= user.getid();
      _uid = 'ExzHS3WoxAZjiGzRLV7xFS0zgsS2';
      print("Current User"+_uid);
      _data = getPosts();//for the very first time it loads up all the data from fireStore

    });


  }
  Future getPosts()async{
    //instantiate FireStore
    //var firestore = Firestore.instance; //giving a FireBase instance
    var query = await Firestore.instance.collection("Received_Services").document(_uid);//accessing shared_services documents
    // print("Getpost "+_uid);
    List<DocumentSnapshot> docs=new List<DocumentSnapshot>();
    query.snapshots().forEach((doc)async{
      //service uid  will be in values
      List<String>values=List.from(doc.data['Service_list']);
      print("Values "+values.toString());
      for(var i=0;i<values.length;i++){
         await Firestore.instance.collection("Shared_Services").where("service_id",isEqualTo:values[i].toString()).getDocuments().then((query){
           docs.addAll(query.documents);
        });

      }
      print("doc size"+docs.length.toString());
    });

     return docs;
  }

  navigateToDetailPage(DocumentSnapshot ReceivedService){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>YourReceivedServiceDetails(ReceivedService: ReceivedService,)));
  }
  @override
  Widget build(BuildContext context){
    print("Build func");
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Received Service"),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Container(
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
                        return ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title:Text(snapshot.data[index].data["service_product_type"]),
                          subtitle: Text(snapshot.data[index].data["uid"]),
                          onTap: () =>navigateToDetailPage(snapshot.data[index]),//passing all data of the document to the detail page
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
