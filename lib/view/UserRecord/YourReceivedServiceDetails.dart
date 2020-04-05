import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
class YourReceivedServiceDetails extends StatefulWidget {
  final DocumentSnapshot ReceivedService;
  YourReceivedServiceDetails({this.ReceivedService});
  @override
  _YourReceivedServiceDetailsState createState() => _YourReceivedServiceDetailsState();
}

class _YourReceivedServiceDetailsState extends State<YourReceivedServiceDetails> {
  String username=""; //otherwise invalid arguments will be shown(only user username will contain null
  String phn="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String useruid =widget.ReceivedService.data["uid"];
    readUserData(useruid);
  }
  Future<void>readUserData(useruid)async{
    var userquery = await Firestore.instance.collection("users").document(useruid);
    userquery.get().then((datasnapshot){
      setState(() {
        username = datasnapshot.data["username"];
        phn = datasnapshot.data["Phone"];
      });

      print("username "+username+"Phone no "+phn);
    });
  }

  //this method used for dynamically fetching image URL ,set them on a list of widgets
  List<Widget> CaroselImageGenarator()
  {
    String Images=widget.ReceivedService.data["images"];
    List<String>imageUrl;
    if(Images!=null)
    {
      Images=Images.trim();
      imageUrl= Images.split(",");

      print("length:  "+imageUrl.length.toString());
    }

    List imageWidgets = new List<Widget>();
    for(var i=0;i<imageUrl.length;i++)
    {
      imageWidgets.add(
        CachedNetworkImage(
          imageUrl:imageUrl[i],
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    }
    return imageWidgets;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ReceivedService.data["service_product_type"]),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //slide showing
            Center(
              child: SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Carousel(                     //Carousel image showing
                    images: CaroselImageGenarator(),
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.purple.withOpacity(0.5),
                    borderRadius: true,
                  )
              ),
            ),
            SizedBox(height: 50,),
            //information about the service
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  children: <Widget>[

                    Text("Username "+username),
                    Text("Phone "+phn),
                  ],
                ),
                SizedBox(width: 10,),
                RaisedButton(
                  child: Text("Chat"),
                  color:Colors.black,
                  onPressed: () {
                      //navigate to particular user's inbox


                  },
                  textColor: Colors.yellow,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                )
              ],
            ),
            Container(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Product Name : "+widget.ReceivedService.data["service_product_name"],style: TextStyle(
                      fontSize: 18
                  ),),

                  Text("price : "+widget.ReceivedService.data["price"],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Available Time : "+widget.ReceivedService.data["available_time"],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Service id : "+widget.ReceivedService.data["service_id"],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Address : "+widget.ReceivedService.data["area"].toString(),style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            SizedBox(height: 120,),


          ],
        ),
      ) ,
    );
  }
}
