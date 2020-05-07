import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/MessageController.dart';
import 'package:share_e/view/Messages/MessagesNotifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'ChatScreen.dart';

class MessageScreen  extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen >  {


  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    super.dispose();


  }

  navigateToDetailPage(BuildContext context,DocumentSnapshot msg)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        ChatScreen(messages:msg ,))
    );
  }
  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<MessagesNotifier>(context);
    return Scaffold(
      backgroundColor: appStyleMode.primaryBackgroundColor,
      body: SafeArea(
        child: Container(
          color: Colors.grey[400],

          child: StreamBuilder(
              stream: MessageController.messagesController.stream, //getting documents of shared_services
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
                          leading: CircleAvatar(
                             child:ClipOval(
                                child: CachedNetworkImage(
                                  width: 100,
                                  height: 100,
                                  imageUrl:imageUrl!=null ? imageUrl[0] : "",
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                            ),
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