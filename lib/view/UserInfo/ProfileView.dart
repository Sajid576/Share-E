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

class FirebaseWrapper {

  static FirebaseAuth _auth;
  static Firestore _firestore;
  static FirebaseStorage _storage;


  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    final FirebaseApp app = await FirebaseApp.configure(
      name: 'ShareEveryThing',
      options: FirebaseOptions(
        googleAppID: '1:556320559446:android:46e924c5bb79c50daa46f7',
        gcmSenderID: '556320559446',
        apiKey: 'AIzaSyAVP4q06zApK6ndsjZ934T4TcYhhs6l508',
        projectID: 'shareeverything-78bb8',
      ),
    );

    _auth = FirebaseAuth.fromApp(app);

    _firestore = Firestore(app: app);

    _storage = FirebaseStorage(app: app, storageBucket: 'gs://shareeverything-78bb8.appspot.com');
  }

  static FirebaseAuth auth() {
    return _auth;
  }

  static Firestore firestore() {
    return _firestore;
  }

  static FirebaseStorage storage() {
    return _storage;
  }
}
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  String _uploadedFileURL="";

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }



  Future uploadPic(BuildContext context) async{
    print("Uploading Pic");
    //final FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://shareeverything-78bb8.appspot.com');
    FirebaseWrapper.init();
    final FirebaseStorage storage=FirebaseWrapper.storage();

    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = storage.ref().child("Users").child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

    if(uploadTask.isInProgress)
      {
          return CircularProgressIndicator();
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
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Edit Profile'),
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
                              child: Text('Michelle James',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
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
                              child: Text('Birthday',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('1st April, 2000',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
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
                              child: Text('Location',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 18.0)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Paris, France',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.pen,
                          color: Color(0xff476cfb),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Email',
                          style:
                          TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                      SizedBox(width: 20.0),
                      Text('michelle123@gmail.com',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    RaisedButton(
                      color: Color(0xff476cfb),
                      onPressed: () {

                        uploadPic(context);
                      },

                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}