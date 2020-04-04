import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import 'package:share_e/view/GoogleMapView.dart';

class AuxiliaryClass{



  static displayAlertDialog(BuildContext context,int currentSearchingTypeIndex) async {
    int index=currentSearchingTypeIndex;
    print("index:  "+index.toString());
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Search by location/Service Name'),

            content: Column(
              mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                Container(
                  width: double.infinity,

                  child: RadioListTile(
                    title: Text("Search by location"),
                    groupValue: index,
                    value: 1,
                    onChanged: (val) {
                      print("selected index(alertbox): "+val.toString());
                      GoogleMapView().setCurrentSearchingIndex(val);
                      Navigator.of(context).pop();
                      displayAlertDialog(context,val);

                    },
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: double.infinity,

                  child: RadioListTile(
                    title: Text("Search by Service name"),
                    groupValue: index,
                    value: 2,
                    onChanged: (val) {
                      print("selected index(alertbox): "+val.toString());
                      GoogleMapView().setCurrentSearchingIndex(val);
                      Navigator.of(context).pop();
                      displayAlertDialog(context,val);

                    },
                  ),
                ),
              ],
            ),
            actions: <Widget>[
               Center(
                 child: FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
              ),
               )
            ],
          );
        });
  }




  static showToast(String msg ){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }



  static Future<bool> checkInternetConnection() async
  {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
    else return false;


  }


}