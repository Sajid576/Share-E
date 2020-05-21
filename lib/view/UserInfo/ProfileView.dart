import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:share_e/AuxilaryClasshelper/AuxiliaryClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  String _uploadedFileURL="";
  String username="";
  String phoneNo="";
  String email="";



  void initState(){
    super.initState();
    SharedPreferenceHelper.readfromlocalstorage().then((user) {

      setState(() {
        phoneNo=user.getphone();
        username = user.getusername();
        email=user.getemail();
        print("username: "+username+", phone: "+phoneNo+",Email: "+email);
      });

    });

  }



  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }



  Future uploadPic(BuildContext context) async{
    print("Uploading Pic");
    final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://share-e-ccfae.appspot.com');
    //FirebaseWrapper.init();
    //final FirebaseStorage storage=FirebaseWrapper.storage();

    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = storage.ref().child("Users").child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

    if(uploadTask.isInProgress)
      {
         // return CircularProgressIndicator();
      }
    if(uploadTask.isComplete)
      {


        firebaseStorageRef.getDownloadURL().then((fileURL) {
          setState(() {
            _uploadedFileURL = fileURL.toString();
            print("download URL: "+_uploadedFileURL);
            //AuxiliaryClass.showToast("Upload Completed");
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
          });
        });
      }



  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {

            }),
        title: Text('My Profile'),
        centerTitle:true,
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) =>  Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Username',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(username,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Email',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(email,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Mobile',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(phoneNo,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RaisedButton(
                      color: Colors.black,
                      onPressed: () {

                        uploadPic(context);
                      },

                      elevation: 4.0,
                      splashColor: Colors.white,
                      child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],



            ),
          ),
        ),
      ),
    );
  }
}