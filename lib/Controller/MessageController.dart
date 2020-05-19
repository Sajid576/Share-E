import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/model/ChatModel.dart';

class MessageController extends ChangeNotifier
{

      Color primaryBackgroundColor = Colors.white;
      Color primaryTextColorDark = Colors.grey[900];
      Color primaryTextColorLight = Colors.grey;
      Color primaryTextColor = Colors.grey[800];
      Color primaryMessageBoxColor = Colors.blue;
      Color secondaryMessageBoxColor = Colors.grey[300];
      Color primaryMessageTextColor = Colors.white;
      Color secondaryMessageTextColor = Colors.grey[800];
      Color typeMessageBoxColor = Colors.grey[200];
      int mode = 0; //0 for light and 1 for dark



/*
  switchMode()
  {



    notifyListeners();

  }*/

      //this controller handles user list of messages
      static StreamController<dynamic> userMessageListController  =  new BehaviorSubject();

      //this controller handles the messages of inbox
      static StreamController< List<Map<dynamic, dynamic>> > inboxController  =  new BehaviorSubject();

      //this function used to fetch conversation of a particular ChatRoom
      static requestFetchConversationsController(String chatRoomId)
      {
            ChatModel.fetchConversation(chatRoomId);
      }
      //this function used to set the realtime conversations list to the Stream
      static setConversationsController( List<Map<dynamic, dynamic>> convoList)
      {
            inboxController.add(convoList);
      }

      static requestCreateNewInboxController(String chatRoomId)
      {
            ChatModel.createUserInbox(chatRoomId);

      }

      static requestSendText(chatRoomId,createdAt,content,senderUsername)
      {
            ChatModel.sendText(chatRoomId,createdAt,content,senderUsername);
      }

}