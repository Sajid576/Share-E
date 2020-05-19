import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/MessageController.dart';

class ChatModel
{


        static getMessagesList(chatList) async
        {

          var listenerQuery=[];
            for(var i=0;i<chatList.length;i++) {
               listenerQuery.add(Firestore.instance.collection('ChatRoom')
                  .where("ChatRoomId", isEqualTo:chatList[i]).getDocuments());
            }

            /*
            for(var i=0;i<listenerQuery.length;i++) {
              listenerQuery[i].snapshots().listen((querySnapshot) {
                querySnapshot.documentChanges.forEach((change) {



                });
              });
            }
*/
        }

        static fetchConversation(chatRoomId) async
        {
          var chatQuery = await Firestore.instance.collection("ChatRoom").document(chatRoomId);
          chatQuery.snapshots().listen((snapshot) {
              List<Map<dynamic, dynamic>> convoList = List.from(snapshot.data['inbox']);
              MessageController.setConversationsController(convoList);
          });

        }

       static createUserInbox(chatRoomId)async
       {
         var uidPair=chatRoomId.split("_");
         var uid1=uidPair[0];
         var uid2=uidPair[1];

         final CollectionReference chatInfo = Firestore.instance.collection('ChatRoom');

          await chatInfo.document(chatRoomId).setData({
             'chatRoomId':chatRoomId,
             'uid1':uid1,
             'uid2':uid2,
         });
       }

       //this function used for sending text to another
      static sendText(chatRoomId,createdAt,content,senderUsername)async
      {
        final CollectionReference chatInfo = Firestore.instance.collection('ChatRoom');

        Map<String, dynamic>data=new Map();

        data['content']=content;
        data['createdAt']=createdAt;
        data['username']=senderUsername;

        var list=new List<Map<String, dynamic>>();
        list.add(data);
        await chatInfo.document(chatRoomId).setData({
            'inbox': FieldValue.arrayUnion(list)
        },merge:true);

      }




}