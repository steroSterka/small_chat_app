import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.dateTime,
  }) : super(key: key);

  final String message;
  final bool isCurrentUser;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isCurrentUser ? ColorUtils.myMessage : ColorUtils.otherMessage,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              message,
              textAlign: isCurrentUser ? TextAlign.right : TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Text(
              dateTime,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
