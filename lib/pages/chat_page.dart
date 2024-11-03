import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {

  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // TEXT CONTROLLER
  final TextEditingController _messageController = TextEditingController();

  // GET CHAT & AUTH SERVICES
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // SEND MESSAGE
  void sendMessage() async {
    // IF THERE IS SOMETHING INSIDE THE TEXT FIELD
    if(_messageController.text.isNotEmpty){
      // SEND MESSAGE
      await _chatService.sendMessage(receiverID, _messageController.text);

      // CLEAR TEXT CONTROLLER
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
      ),

      body: Column(
        children: [
          // DISPLAY ALL MESSAGES
          Expanded(child: _buildMessageList(),
          ),

          // USER INPUT
          _buildUserInput(),
        ],
      ),
    );
  }

  // BUILD MESSAGE LIST
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot){

          // ERRORS
          if(snapshot.hasError){
            return Text('Error');
          }

          // LOADING
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading..');
          }

          // RETURN LISTVIEW
          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList()
          );
        },
    );
  }

  // BUILD MESSAGE ITEM
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // IS CURRENT USER
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // ALIGN MESSAGE TO THE RIGHT IF THE SENDER IS CURRENT USER, OTHERWISE LEFT
    var alignment =
        isCurrentUser? Alignment.centerRight : Alignment.centerLeft;
    
    return Container(
        alignment: alignment,
        child: Column(
            children: [
              ChatBubble(
                  message: data['message'],
                  isCurrentUser: isCurrentUser)
            ],
        ),
    );
  }

  // BUILD MESSAGE INPUT
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [

          // TEXT FIELD SHOULD TAKE UP MOST OF THE SPACE
          Expanded(
            child: MyTextField(
              hintText: 'Type a message',
              obscureText: false,
              controller: _messageController),
          ),

          // SEND BUTTON
          Container(
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.arrow_upward,
                    size: 30,
                    color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }
}