import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:share_e/model/FirebaseShareServiceModel.dart';
import 'package:share_e/view/UserRecord/ShareYourServices.dart';
import 'package:rxdart/rxdart.dart';

class ShareServiceProductHelper {

  //for all radio button set state
  static String character1=" ";
  //stream controller
  static StreamController<dynamic> streamController = new BehaviorSubject();
  static StreamController<dynamic> BookTYpeController = new BehaviorSubject();

  //medicine
  static TextEditingController medicineName = TextEditingController();
  static TextEditingController medicineDetails = TextEditingController();
  static TextEditingController medicinePrice = TextEditingController();
  static TextEditingController medicineQuantity = TextEditingController();
  static TextEditingController medicineExpDate = TextEditingController();

  //vehicle
  static TextEditingController vehicleType = TextEditingController();
  static TextEditingController vehicleModel = TextEditingController();
  static TextEditingController vehiclePrice = TextEditingController();
  //_foodfruitname

  static TextEditingController foodfruitname = TextEditingController();
  static TextEditingController foodfruitquantity = TextEditingController();
  static TextEditingController foodfruitprice = TextEditingController();

//book
  static TextEditingController bookname = TextEditingController();
  static TextEditingController writername = TextEditingController();
  static TextEditingController bookquantity = TextEditingController();
  static TextEditingController bookprice = TextEditingController();

  //parking
  static TextEditingController parkingprice = TextEditingController();
  static TextEditingController buildingname = TextEditingController();

//house rent
  static TextEditingController bedroomnumber = TextEditingController();
  static TextEditingController flatspace = TextEditingController();
  static TextEditingController washroomnumber = TextEditingController();
  static TextEditingController balconyquantity = TextEditingController();
  static TextEditingController houseprice = TextEditingController();

  //mechanic
  static TextEditingController mechanicdetails = TextEditingController();


  final _address = TextEditingController();
  final _name = TextEditingController();
  var _username;
  List<Asset> images = List<Asset>();
  String _error = 'No image selected';
  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Share-E",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      _error = error;
      AuxiliaryClass.showToast(_error);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    if (resultList.length == 0) {
      AuxiliaryClass.showToast("You didnt select any image");
      return;
    }
    images = resultList;

    /* for(int i=0;i<images.length;i++){
      imageList.add(await images[i].getByteData());

    }*/
    _error = "images selected " + images.length.toString();

    streamController.add("12");
  }

  Widget medicineLayout() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
           
            Card(
              child: TextFormField(
                decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.healing, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Medicine Name"),
                controller: medicineName,
              ),
            ),
            SizedBox(
              height: 10,
            ),
           
            Card(
              child: TextFormField(
                decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.details, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "details"),
                controller: medicineDetails,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(

              child: RaisedButton(
                child: Text("Pick images"),
                onPressed: loadAssets,
              ),
            ),
            Container(
              margin:  EdgeInsets.only(left: 0, right: 0, bottom: 20),
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5 ,top:5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildGridView(),
            ),
           
            Card(
              child: TextFormField(
                decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.attach_money, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Price"),
                controller: medicinePrice,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_list_numbered, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Quantity"),
                controller: medicineQuantity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
           
            Card(
              child: TextFormField(
                decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.date_range, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Exp.date"),
                controller: medicineExpDate,
              ),
            ),


            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget vehicleshareing() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.local_car_wash, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Vehicle type"),
                controller: vehicleType,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.mode_edit, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Model"),
                controller: vehicleModel,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Container(
              margin:  EdgeInsets.only(left: 0, right: 0, bottom: 20),
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5 ,top:5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildGridView(),
            ),
            
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.attach_money, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Price"),
                controller: vehiclePrice,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget Food_Grocery_Fruit() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text("Which type you want to share?"),
            ),
            ListTile(
              title: const Text('Food'),
              leading: Radio(
                value: "Food",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                  // setState(() {  });
                },
              ),
            ),
            ListTile(
              title: const Text('Fruit'),
              leading: Radio(
                value: "Fruit",
                groupValue: character1,
                onChanged: ( value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.fastfood, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Name"),
                controller: foodfruitname,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_list_numbered, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Quantity"),
                controller: foodfruitquantity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Container(
              margin:  EdgeInsets.only(left: 0, right: 0, bottom: 20),
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5 ,top:5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildGridView(),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.attach_money, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Price"),
                controller: foodfruitprice,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget book_sharing() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('Engineering'),
              leading: Radio(
                value: "Engineering",
                groupValue: character1,
                onChanged: ( value) {
                  character1 = value;

                  print(character1);
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('science fiction'),
              leading: Radio(
                value: "Sciencefiction",
                groupValue: character1,
                onChanged: ( value) {
                  character1 = value;
                  print(character1);
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('novel'),
              leading: Radio(
                value: "Novel",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print(character1);
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('comic'),
              leading: Radio(
                value: "Comic",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  BookTYpeController.add(true);
                  print(character1.toString());
                },
              ),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.book, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Book Name"),
                controller: bookname,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.person_pin, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Writer Name"),
                controller: writername,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_list_numbered, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Quantity"),
                controller: bookquantity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Container(
              margin:  EdgeInsets.only(left: 0, right: 0, bottom: 20),
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5 ,top:5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildGridView(),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.attach_money, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Price"),
                controller: bookprice,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget parking_sharing() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('car'),
              leading: Radio(
                value: "Car",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  BookTYpeController.add(true);
                  print(character1.toString());
                },
              ),
            ),
            ListTile(
              title: const Text('bike'),
              leading: Radio(
                value: "Bike",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  BookTYpeController.add(true);
                  print(character1.toString());
                },
              ),
            ),
            ListTile(
              title: const Text('bus'),
              leading: Radio(
                value: "Bus",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  BookTYpeController.add(true);
                  print(character1.toString());
                },
              ),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.home, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Building Name"),
                controller: buildingname,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Container(
              margin:  EdgeInsets.only(left: 0, right: 0, bottom: 20),
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5 ,top:5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildGridView(),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.attach_money, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Price"),
                controller: parkingprice,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget house_rent() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Available for"),
            ListTile(
              title: const Text('Bachelor'),
              leading: Radio(
                value: "Bechelor",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('Family'),
              leading: Radio(
                value: "Family",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("selected" + "$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_list_numbered_rtl, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Bed Room Quantity"),
                controller: bedroomnumber,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_line_spacing, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Flat Space(Square Feet)"),
                controller: flatspace,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_list_numbered, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Washroom Quantity"),
                controller: washroomnumber,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.format_list_numbered, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Balcony Quantity"),
                controller: balconyquantity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Container(
              margin:  EdgeInsets.only(left: 0, right: 0, bottom: 20),
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5 ,top:5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: buildGridView(),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.attach_money, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Price"),
                controller: houseprice,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mechanic_service() {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Mechanic Type",style: TextStyle(fontSize: 10,),),),
            ListTile(
              title: const Text('Electrical'),
              leading: Radio(
                value: "Electrical",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('Electronics'),
              leading: Radio(
                value: "Electronics",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('Water Line'),
              leading: Radio(
                value: "Waterline",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('Computer'),
              leading: Radio(
                value: "Computer",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            ListTile(
              title: const Text('Laptop'),
              leading: Radio(
                value: "Laptop",
                groupValue: character1,
                onChanged: (value) {
                  character1 = value;
                  print("$character1");
                  BookTYpeController.add(true);
                },
              ),
            ),
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    icon: Icon(Icons.details, color: Colors.deepPurple,),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Details"),
                controller: mechanicdetails,
              ),
            ),
            SizedBox(
              height: 10,
            ),


          ],
        ),
      ),
    );
  }
}
