import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import '../services/auth/auth_service.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // CHAT & AUTH SERVICE
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text('Home'),
        centerTitle: true,
      ),

      // DRAWER
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: _buildUserList(),
      ),
    );
  }

  // BUILD A LIST OF USERS EXCEPT FOR THE CURRENT LOGGED IN USER
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot){
          // ERROR
          if (snapshot.hasError){
            return Text("Error");
          }

          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading..");
          }

          // RETURN LIST VIEW
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        }
    );
  }

  // BUILD INDIVIDUAL LIST TILE FOR USER
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {

    // DISPLAY ALL USERS EXCEPT CURRENT USER
    if(userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(text: userData['email'],
        onTap: (){

          // TAPPED ON A USER GO TO CHAT PAGE
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverID: userData['uid'],
                ),
              ),
          );
        },
      );
    } else {
      return Container();
    }
}
}