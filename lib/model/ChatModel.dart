
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/MessageController.dart';

class ChatModel
{
         List<Map<dynamic, dynamic>> main_list=new List<Map<dynamic, dynamic>>();


         //this function fetches all
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
                  Map<dynamic, dynamic> mp = Map.from(change.document.data);


                  List<Map<dynamic, dynamic>> values = List.from(change.document.data['inbox']);
                  print('inbox:' + values.toString() + '--');
                  //documentSnapshot.addAll();


                });
              });
            }
*/





        }


       static createUserInbox(chatRoomId)
       {

       }






}