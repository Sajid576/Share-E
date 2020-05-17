
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/model/ChatModel.dart';

class MessageController
{

      static StreamController<List<DocumentSnapshot>> messagesController  =  new BehaviorSubject();




      static setRequestInboxController(String chatRoomId)
      {
            ChatModel.createUserInbox(chatRoomId);

      }

}