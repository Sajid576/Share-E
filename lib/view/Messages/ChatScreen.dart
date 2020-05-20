import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_e/Controller/MessageController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class ChatScreen extends StatefulWidget {

  final String username;
  final String myUsername;
  final String chatRoomId;

  ChatScreen(this.username, this.myUsername, this.chatRoomId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List<Map<dynamic, dynamic>> inboxList=new List<Map<dynamic, dynamic>>();
  TextEditingController messageController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //this stream controller update the UI whenever a new list of messages will arrive.Technically when a new message
    //is sent by other user this stream controller will update the UI with new set of messages in realtime

    MessageController.inboxController.stream.listen((inboxList) {
      if(inboxList!=null)
        {
          this.inboxList=inboxList;
        }

      setState(() {
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  List<Widget> messageLayout()
  {

    List<Widget> messageWidgets=new List<Widget>();
    for(var i=0;i<inboxList.length;i++)
      {
            var messageMapping=inboxList[i];

            var uName=messageMapping['username'];
            if(uName==widget.username)
              {
                //container for other user messages
                messageWidgets.add( Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                            color: Colors.grey[300]
                        ),
                        child: Text(messageMapping['content'], style: GoogleFonts.roboto(textStyle: TextStyle(
                            color: Colors.black
                        )),),

                      ),
                      //paste it

                      SizedBox(height: 4,),
                      Text(DateFormat('kk:mm:ss \n EEE d MMM').format(messageMapping['createdAt'].toDate()), style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.grey)),)

                    ],
                  ),
                  alignment: Alignment.bottomLeft,
                ));
              }
            else
              {
                //Container my messages
                messageWidgets.add( Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
                          color: Colors.blue,
                        ),
                        child: Text(messageMapping['content'], style: GoogleFonts.roboto(textStyle: TextStyle(
                          color: Colors.white,
                        )),),

                      ),
                      //paste it

                      SizedBox(height: 4,),
                      Text(DateFormat('kk:mm:ss \n EEE d MMM').format(messageMapping['createdAt'].toDate()), style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.grey)),)

                    ],
                  ),
                  alignment: Alignment.bottomRight,
                ));
              }
      }

    return messageWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final appStyleMode = Provider.of<MessageController>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Container for the setting the other user name name

          Container(
            margin: EdgeInsets.only(top: 32, left: 16, right: 16),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                Text(widget.username, style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.w500, textStyle: TextStyle(color: Colors.white)),),
                Icon(Icons.refresh, size: 30, color: Colors.white,)

              ],
            ),
          ),

          SizedBox(height: 16,),

          //DraggableContainer for messages
          Expanded(
            child: DraggableScrollableSheet(
              builder: (context, scrollController){
                return Container(
                  decoration: BoxDecoration(
                    color: appStyleMode.primaryBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                  ),
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children:  messageLayout(),
                        //Text("", style: GoogleFonts.roboto(textStyle: TextStyle(color: appStyleMode.primaryTextColor, fontWeight: FontWeight.w500)),),

                        //SizedBox(height: 32,),

                        //SizedBox(height: 32,),


                    ),
                  ),
                );
              },
              initialChildSize: 1.0,
              minChildSize: 1.0,
              expand: true,
            ),
          ),

          //Conatiner for typing message

          Container(
            padding: EdgeInsets.all(16),
            color: appStyleMode.primaryBackgroundColor,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.transparent)
                        ),
                        filled : true,
                        fillColor: appStyleMode.typeMessageBoxColor,
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                        hintText: "Type message",
                        hintStyle: GoogleFonts.roboto(textStyle: TextStyle(color: appStyleMode.primaryTextColorLight))

                    ),
                  ),
                ),
                SizedBox(width: 16,),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue,),
                  onPressed: ()
                  {

                        var content=messageController.text;

                        DateTime currentPhoneDate = DateTime.now(); //DateTime

                        Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

                        //DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime
                        print("Pressed!!!"+myTimeStamp.toString()+"---"+content);
                        MessageController.requestSendText(widget.chatRoomId, myTimeStamp,content, widget.myUsername);
                        messageController.text="";
                   },

                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
