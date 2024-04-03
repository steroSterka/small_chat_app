import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:small_chat_app/controllers%20/services/auth/auth_service.dart';
import 'package:small_chat_app/controllers%20/services/chat/chat_service.dart';
import 'package:small_chat_app/pages/login/widgets/login_textfield.dart';
import 'package:small_chat_app/utils/utils.dart';

import '../../components/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  final TextEditingController messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      chatService.sendMessage(receiverID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiverEmail),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(child: buildMessagesList()),
            buildUserInput(),
          ],
        ));
  }

  Widget buildMessagesList() {
    String senderID = authService.currentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(senderID, receiverID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => buildMessageItems(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageItems(doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == authService.currentUser()!.uid;
    String message = data['message'];
    Utils.getDateAndTime(doc);

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(
            message: message,
            isCurrentUser: isCurrentUser,
            dateTime: Utils.getDateAndTime(doc))
      ],
    );
  }

  Widget buildUserInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Iconsax.camera)),
          Expanded(
            child: LoginTextfield(
              controller: messageController,
              hintText: 'Type a message',
              obscureText: false,
            ),
          ),
          IconButton(
            icon: const Icon(Iconsax.send_1),
            onPressed: sendMessage,
          )
        ],
      ),
    );
  }
}
