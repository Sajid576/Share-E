
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';


class AllSharedServiceDetail extends StatefulWidget {         //this is for if user tabs any item of the listpage then the detail page will loads up
  final DocumentSnapshot sharedServices;

  AllSharedServiceDetail({this.sharedServices});
  @override
  _AllSharedServiceDetailState createState() => _AllSharedServiceDetailState();
}

class _AllSharedServiceDetailState extends State<AllSharedServiceDetail> {
  //GlobalKey<FormState> _homeKey = GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  String username=""; //otherwise invalid arguments will be shown(only user username will contain null
  String phn="";


  @override
  void initState() {
    super.initState();
    String uid = widget.sharedServices.data["uid"];
    print(uid);
    readUserData(uid.trim());
  }

  Future<void>readUserData(uid)async{
    var query = await Firestore.instance.collection('users').document(uid);
    print("ki uid"+uid);


    query.get().then((datasnapshot) {
      if (datasnapshot.exists) {
       // i++;
        //print("counter"+i.toString());
        setState(() {
          print(datasnapshot.data['username'].toString());
          print(datasnapshot.data['Phone'].toString());
          username = datasnapshot.data['username'];
          phn = datasnapshot.data['Phone'];
        });

      }
      else{
        print("No such user");
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sharedServices.data["service_product_type"]),
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              //uid =widget.sharedServices.data["uid"],
              Center(
                child: SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: Carousel(                     //Carousel image showing
                      images: [
                        AssetImage('assets/Me.png'),
                        AssetImage('assets/book_ico.png'),
                        AssetImage('assets/vehicle_ico.png'),
                        AssetImage('assets/food_ico.jpg'),
                      ],
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0.5),
                      borderRadius: true,
                    )
                ),
              ),


              SizedBox(
                height: 20,
              ),
              Container(            //showing all the information given for shared service(type, price,area)

                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(

                            children: <Widget>[
                              Text("Username "+username),
                              Text("Phone "+phn),
                            ],
                          ),
                          SizedBox(width: 15,),
                          RaisedButton(
                            color: Colors.red,
                            onPressed: null,
                            child: Text(
                              'chat',
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                          ),
                        ],

                      ),
                      Text("Product Name : "+widget.sharedServices.data["service_product_name"],style: TextStyle(
                          fontSize: 18
                      ),),

                      Text("price : "+widget.sharedServices.data["price"],style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10,),
                      Text("Available Time : "+widget.sharedServices.data["available_time"],style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10,),
                      Text("Service id : "+widget.sharedServices.data["service_id"],style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10,),
                      Text("Address : "+widget.sharedServices.data["area"].toString(),style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


