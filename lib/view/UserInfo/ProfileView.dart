import 'dart:typed_data';

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
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'dart:io' as Io;
import 'dart:convert';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //if an new image selected to change the dp then this _image variable will be initialized otherwise it will be null
  File _image;
  //after uploading the file to firebase storage, this variable have the download URL of that image that has to be stored
  //in cloud firestore
  String _uploadedFileURL="";


  String username="";
  String phoneNo="";
  String email="";
  String uid="";
  String userDP="";

  bool editEnabled=false;
  TextEditingController _usernameEditingController;
  TextEditingController _phoneNoEditingController;

  void initState(){
    super.initState();



    SharedPreferenceHelper.readfromlocalstorage().then((user) {

      setState(() {
        userDP=user.getDP();
        uid=user.getuid();
        phoneNo=user.getphone();
        username = user.getusername();
        email=user.getemail();

        _phoneNoEditingController=TextEditingController(text: phoneNo);
        _usernameEditingController=TextEditingController(text: username);

        print("UID: "+uid+",username: "+username+", phone: "+phoneNo+",Email: "+email);
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



  uploadPicToDb(imagePath,uid)
  {
      final bytes = Io.File(imagePath).readAsBytesSync();

      String img64 = base64Encode(bytes);

      FirebaseService.uploadUserDP(uid, img64);
      SharedPreferenceHelper.setUserDP(img64);

  }

  Future uploadPic(BuildContext context) async{
    print("Uploading Pic");


    String fileName = basename(_image.path);
    // Upload image to firebase.
    try {
      final StorageReference storageReference = FirebaseStorage.instance.ref()
          .child("users")
          .child(fileName);
      final StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      if (uploadTask.isComplete) {
        storageReference.getDownloadURL().then((fileURL) {
          setState(() {
            _uploadedFileURL = fileURL.toString();
            print("download URL: " + _uploadedFileURL);
            //AuxiliaryClass.showToast("Upload Completed");
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Profile Picture Uploaded')));
          });
        });
      }
    }catch(Exception)
    {
      AuxiliaryClass.showToast(Exception.message());
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
                        backgroundColor: Colors.black45,
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
                   editEnabled? Padding(
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
                    ): Container(

                   ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Column(
                      children: [


                        Text('Username',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                        editEnabled? TextField(
                          enabled: editEnabled,
                          onChanged: (text) {

                            _usernameEditingController.text = text;
                            _usernameEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _usernameEditingController.text.length));

                          },
                          controller: _usernameEditingController,
                        ) : Text(username,
                            style: TextStyle(
                                color: Colors.black, fontSize: 18.0)),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Email',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                        Text(email,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Mobile',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 18.0)),
                        editEnabled ? TextField(
                          enabled: editEnabled,
                          onChanged: (text) {

                            _phoneNoEditingController.text = text;
                            _phoneNoEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _phoneNoEditingController.text.length));

                          },
                          controller: _phoneNoEditingController,
                        ): Text(phoneNo,
                            style: TextStyle(
                                color: Colors.black, fontSize: 18.0)),

                      ],
                    ),
                  ),
                ),



                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RaisedButton(
                      color: editEnabled ? Colors.green : Colors.black,
                      onPressed: () {
                        if(editEnabled)
                          {
                            if(_image!=null)
                              {
                                uploadPic(context);
                                //uploadPicToDb(_image.path,uid);
                              }
                            if(username!=_usernameEditingController.text || phoneNo!=_phoneNoEditingController.text)
                              {
                                username=_usernameEditingController.text;
                                phoneNo=_phoneNoEditingController.text;
                                SharedPreferenceHelper.updateLocalData(phoneNo, username);
                                FirebaseService.editUserData(phoneNo, username, uid);
                              }

                          }
                         setState(() {
                           editEnabled=!editEnabled;
                         });

                      },

                      elevation: 4.0,
                      splashColor: Colors.white,
                      child:editEnabled? Text('Save Info', style: TextStyle(color: Colors.white, fontSize: 16.0),) : Text('Edit Info', style: TextStyle(color: Colors.white, fontSize: 16.0),),
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