
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class MessageController
{

      static StreamController<List<DocumentSnapshot>> messagesController  =  new BehaviorSubject();


      static setMessageController()
      {

      }

}