import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          color: isCurrentUser? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)),
      child: Text(message,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15),
      ),
    );
  }
}