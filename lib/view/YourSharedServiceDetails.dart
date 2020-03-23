import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
class YourSharedServiceDetails extends StatefulWidget {
  final DocumentSnapshot Yoursharedservice;
  YourSharedServiceDetails({this.Yoursharedservice});
  @override
  _YourSharedServiceDetailsState createState() => _YourSharedServiceDetailsState();
}

class _YourSharedServiceDetailsState extends State<YourSharedServiceDetails> {
  @override
  Widget build(BuildContext context) {
    bool isButtonPressed = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Yoursharedservice.data["service_product_type"]),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body:SafeArea(
        child: Column(
          children: <Widget>[
            //slide showing
            Center(
              child: SizedBox(
                  height: 200.0,
                  width: 350.0,
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
            SizedBox(height: 50,),
            //information about the service

            Container(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Product Name : "+widget.Yoursharedservice.data["service_product_name"],style: TextStyle(
                      fontSize: 18
                  ),),

                  Text("price : "+widget.Yoursharedservice.data["price"],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Available Time : "+widget.Yoursharedservice.data["available_time"],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Service id : "+widget.Yoursharedservice.data["service_id"],style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                  Text("Address : "+widget.Yoursharedservice.data["area"].toString(),style: TextStyle(fontSize: 18),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            SizedBox(height: 120,),
            //button edit and Save

            Padding(
              padding: EdgeInsets.only(left: 95),
              child: Container(
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Edit"),
                      color: isButtonPressed ? Colors.redAccent : Colors.black,
                      onPressed: () {
                        setState(() {
                          isButtonPressed =!isButtonPressed;
                        });
                      },
                      textColor: Colors.yellow,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton(
                      child: Text("Save"),
                      color: isButtonPressed ? Colors.redAccent : Colors.green,
                      onPressed: () {
                        setState(() {
                          isButtonPressed =!isButtonPressed;
                        });
                      },
                      textColor: Colors.yellow,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
             SizedBox(height: 40,),
             //button Stop service

             RaisedButton(
               child: Text("Stop Service"),
               color: isButtonPressed ? Colors.redAccent : Colors.red,
               onPressed: () {
                 setState(() {
                   isButtonPressed =!isButtonPressed;
                 });
               },
               textColor: Colors.yellow,
               padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
               splashColor: Colors.grey,
             )
          ],
        ),
      ) ,
    );
  }
}
