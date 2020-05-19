import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/MessageController.dart';
import 'package:share_e/model/ChatModel.dart';
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


  String myUsername="";
  var chatRoomIdList=[];
  var othersUsernameList=[];

  checkChatRoom(String uid,String myUid)
  {
        String chatRoomId1=uid+"_"+myUid;
        String chatRoomId2=myUid+"_"+uid;

        //by default chatRoomId value is chatRoomId1
        String chatRoomId=chatRoomId1;
        var exists=false;

         for(var i=0;i<chatRoomIdList.length;i++)
         {
             if(chatRoomId1.contains(chatRoomIdList[i]))
             {
                    chatRoomId=chatRoomId1;
                    exists=true;
                    break;

             }
             if(chatRoomId2.contains(chatRoomIdList[i]))
             {
                    chatRoomId=chatRoomId2;
                    exists=true;
                    break;

             }
         }

         Map<String,dynamic>chatMap=Map();
         chatMap['chatRoomId']=chatRoomId;
         chatMap['exists']=exists;

         return chatMap;

  }

  createChatRoom(BuildContext context,String username)
  {


        var chatMap = checkChatRoom(username,myUsername);
        var chatRoomId=chatMap['chatRoomId'];
        if(chatMap['exists'])
          {
              MessageController.requestFetchConversationsController(chatRoomId);
          }
        else
          {
             //if the chat room doesn't exist ,request for creating new chat Room

             MessageController.requestCreateNewInboxController(chatRoomId);

          }

        navigateToChatScreenPage(context,username,myUsername,chatRoomId);

  }
  navigateToChatScreenPage(BuildContext context,String username,String myUsername,String chatRoomId)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        ChatScreen(username,myUsername,chatRoomId))
    );
  }
  @override
  void initState() {
    super.initState();

    SharedPreferenceHelper.readfromlocalstorage().then((user) {
          //fetch uid from local storage
          //myUid=user.getuid();
          myUsername="Sajid576";

          //fetch list of chatRoomId from local storage
          //chatRoomIdList= user.myChatList();
          chatRoomIdList.add("Sajid576_sajju");

          for(var i=0;i<chatRoomIdList.length;i++)
            {
               var chatRoomId=chatRoomIdList[i];
               chatRoomId=chatRoomId.trim();

               var usernamePair=chatRoomId.split("_");
               var username1=usernamePair[0];
               var username2=usernamePair[1];

               if(myUsername==username1)
               {
                 othersUsernameList.add(username2);
               }
               if(myUsername==username2)
               {
                 othersUsernameList.add(username1);
               }

            }
            MessageController.userMessageListController.add(othersUsernameList);



    });

  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<MessageController>(context);
    return Scaffold(
      backgroundColor: appStyleMode.primaryBackgroundColor,
      appBar: AppBar(
        title: Center(child: Text("Messages")),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[400],

          child: StreamBuilder(
              stream: MessageController.userMessageListController.stream,
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
                          padding: const EdgeInsets.only(left:0 ,top: 5, right: 10 ,bottom: 5),
                          child: GestureDetector(
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
                              contentPadding: EdgeInsets.all(8),
                              title: Text(snapshot.data[index] ,style:TextStyle(color: Colors.black ,fontWeight: FontWeight.bold,fontSize: 20),),
                              //subtitle: Text("New Message",style:TextStyle(color: Colors.red),),

                            ),
                            //passing username to the createChatRoom()
                            onTap: () => createChatRoom(context, snapshot.data[index]),
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
