import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/Controller/FutureHolder.dart';

import 'AllSharedServiceDetail.dart';

class AllSharedServices  {
  static var i=1;

  navigateToDetailPage(BuildContext context,DocumentSnapshot sharedServices)
  {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                AllSharedServiceDetail(sharedServices: sharedServices))
      );

  }
  @override
  Widget AllSharedServiceslayout(BuildContext context) {
    print("build hoise:  "+i.toString()+" bar  ");
    i++;


      return Container(
        color: Colors.grey[400],
        //bringing data from cloud fireStore through 'FutureBuilder'
        child: FutureBuilder(
          initialData: FutureHolder.data,
            future: FutureHolder.data, //getting documents of shared_services
            builder: (_, snapshot) { //snapshot has all the array data
              //if it's not yet come from fireBase
              if(snapshot.data==null)
              {
                return Center(
                  child: Text("NULL"),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print("have my data");
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  //shared_service document array size
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      //srollable
                      child: Container(
                        height: 20.0,
                        width: 0.0,
                        child: ListTile(
                          leading: Image.network("https://upload.wikimedia.org/wikipedia/commons/d/dc/2015_Chevrolet_Tahoe_LT_5.3L_front_02_3.24.19.jpg"),
                          contentPadding: EdgeInsets.all(8),
                          title: Text(snapshot.data[index].data["service_product_type"]),
                          subtitle: Text(snapshot.data[index].data["service_product_name"]),
                          onTap: () => navigateToDetailPage(context, snapshot.data[index]), //passing all data of the document to the detail page
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.black,
                    );
                  },
                );
              }
            }
        ),
      );


    }
  }

