import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/MessageController.dart';
import 'package:share_e/model/ChatModel.dart';
import 'package:share_e/view/Messages/MessagesNotifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_e/model/SharedPreferenceHelper.dart';
import 'ChatScreen.dart';

class MessageScreen  extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen >  {

  String myUid="";
  var chatRoomIdList=[];
  var othersUid=[];

  getChatRoomId(String uid,String myUid)
  {
        String chatRoomId1=uid+"_"+myUid;
        String chatRoomId2=myUid+"_"+uid;

        //by default chatRoomId value is chatRoomId1
        String chatRoomId=chatRoomId1;

         for(var i=0;i<chatList.length;i++)
         {
             if(chatRoomId1.contains(chatList[i]))
             {
                    chatRoomId=chatRoomId1;
                    return chatRoomId;
             }
             if(chatRoomId2.contains(chatList[i]))
             {
                    chatRoomId=chatRoomId2;
                    return chatRoomId;
             }
         }

        return chatRoomId;

  }

  createChatRoom(BuildContext context,DocumentSnapshot msg,String uid)
  {

        var chatRoomId = getChatRoomId(uid,myUid);
        MessageController.setRequestInboxController(chatRoomId);


  }

  @override
  void initState() {
    super.initState();



    SharedPreferenceHelper.readfromlocalstorage().then((user) {
          //fetch uid from local storage
          //myUid=user.getuid();
          myUid="6FViFtOTqTgoZ9IMv3nMOqAXuqM2";

          //fetch list of chatRoomId from local storage
          chatRoomIdList= user.myChatList();
          for(var i=0;i<chatRoomIdList.length;i++)
            {
               var chatRoomId=chatRoomIdList[i];
               chatRoomId=chatRoomId.trim();

               var uidPair=chatRoomId.split("_");
               var uid1=uidPair[0];
               var uid2=uidPair[1];

               if(myUid==uid1)
               {
                 othersUid.add(uid2);
               }
               if(myUid==uid2)
               {
                 othersUid.add(uid1);
               }

            }
            MessageController.messagesController.add(othersUid);


    });

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
              stream: MessageController.messagesController.stream,
              builder: (_, snapshot) {
                //snapshot has all the array data


                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {

                  return ListView.separated(
                    itemCount: snapshot.data.length,
                    //shared_service document array size
                    itemBuilder: (BuildContext context, int index) {
                      String dp;

                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left:10 ,top: 5, right: 10 ,bottom: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                               child:ClipOval(
                                  child:dp!=null ? CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    imageUrl:dp,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ) : new Image(
                                      image: new AssetImage('assets/person.png'),
                                      width:100,
                                      height:100,
                                  ),
                              ),
                            ),
                            //contentPadding: EdgeInsets.all(8),
                            title: Text(snapshot.data[index].data["uid"]),
                            //subtitle: Text(snapshot.data[index].data["service_product_name"]),
                            onTap: () => createChatRoom(context, snapshot.data[index],snapshot.data[index].data["uid"]), //passing all data of the document to the detail page
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
        ),
      ),
    );

  }




}
