import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import 'package:share_e/view/GoogleMapView.dart';

class AuxiliaryClass{


  static alertboxCallback(val)
  {
    new GoogleMapView().setCurrentSearchingIndex(val);
  }
  static displayAlertDialog(BuildContext context,int currentSearchingTypeIndex) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Search by location/product name'),

            content: Column(
              children: <Widget>[
                RadioListTile(
                  title: Text("Search by location"),
                  groupValue: currentSearchingTypeIndex,
                  value: 1,
                  onChanged: (val) {
                    alertboxCallback(val);
                    print("selected index(alertbox): "+val);

                  },
                ),
                RadioListTile(
                  title: Text("Search by product name"),
                  groupValue: currentSearchingTypeIndex,
                  value: 2,
                  onChanged: (val) {
                    alertboxCallback(val);
                    print("selected index(alertbox): "+val);

                  },
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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