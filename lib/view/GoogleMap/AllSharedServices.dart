import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:share_e/model/FirebaseService.dart';
import 'package:share_e/Controller/GetAllSharedServiceController.dart';

import 'AllSharedServiceDetail.dart';
class AllSharedServices extends StatefulWidget {
  @override
  _AllSharedServicesState createState() => _AllSharedServicesState();
}

class _AllSharedServicesState extends State<AllSharedServices> with AutomaticKeepAliveClientMixin<AllSharedServices> {


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  /*
        In this Listview Page we are using the mixin and returning true, indicating that we want to maintain
        the content of the page .so every time the Tab is selected, the initState method is only executed once,
         at the time of creation.

        On the other hand, In the case of GoogleMap Layout page, we are not using the mixin, so every time the tab
        is selected, enter initState and reload the content.
   */
  @override
  void initState() {
      super.initState();

      //GetAllSharedServiceController.requestAllSharedService();
  }

  @override
  void dispose() {
    super.dispose();


  }

  navigateToDetailPage(BuildContext context,DocumentSnapshot sharedServices)
  {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                AllSharedServiceDetail(sharedServices: sharedServices))
      );
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.grey[400],

            child: StreamBuilder(
                stream: GetAllSharedServiceController.AllServicedataController.stream, //getting documents of shared_services
                builder: (_, snapshot) { //snapshot has all the array data
                  //if it's not yet come from fireBase

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {

                    return ListView.separated(
                      itemCount: snapshot.data.length,
                      //shared_service document array size
                      itemBuilder: (BuildContext context, int index) {

                        String images=snapshot.data[index].data["images"];
                        List<String>imageUrl;
                        if(images!=null)
                        {
                          images=images.trim();
                          imageUrl= images.split(",");
                        }

                        return Container(
                          color: Colors.white,
                          child: ListTile(
                              leading: CachedNetworkImage(
                              width: 100,
                              height: 100,
                              imageUrl:imageUrl!=null ? imageUrl[0] : "",
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            title: Text(snapshot.data[index].data["service_product_type"]),
                            subtitle: Text(snapshot.data[index].data["service_product_name"]),
                            onTap: () => navigateToDetailPage(context, snapshot.data[index]), //passing all data of the document to the detail page
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
          ),
        ),
      );


    }


  }

