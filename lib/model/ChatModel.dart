
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_e/Controller/MessageController.dart';

class ChatModel
{
         List<Map<dynamic, dynamic>> main_list=new List<Map<dynamic, dynamic>>();

        getMessagesList(uid) async
        {

            var query = await Firestore.instance.collection('users').document(uid);
           
            List<dynamic> documentSnapshot=new List<dynamic>();

            query.get().then((snapshot) async{
                List<String>inboxList=List.from(snapshot.data["user_inboxList"]);


                var listenerQuery = await Firestore.instance.collection('chats');


                listenerQuery.snapshots().listen((querySnapshot) {
                  querySnapshot.documentChanges.forEach((change) {

                    Map<dynamic, dynamic> mp = Map.from(change.document.data);

                    String chatId=mp['chatId'];

                    if(inboxList.contains(chatId))
                      {
                          List<Map<dynamic, dynamic>> values = List.from(change.document.data['inbox']);
                          print('inbox:' + values.toString() + '--');
                          //documentSnapshot.addAll();

                      }


                  });

                });


            });




        }





}