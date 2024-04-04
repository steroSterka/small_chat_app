import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:small_chat_app/controllers%20/services/auth/auth_service.dart';
import 'package:small_chat_app/controllers%20/services/chat/chat_service.dart';
import 'package:small_chat_app/pages/login/widgets/login_textfield.dart';
import 'package:small_chat_app/utils/utils.dart';

import '../../components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();

  final AuthService authService = AuthService();

  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverID, messageController.text);
      messageController.clear();
    }
    scrolDown();
  }

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), ()=> scrolDown());
      } 
    });

  Future.delayed(const Duration(milliseconds: 500), ()=> scrolDown());


  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  void scrolDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverEmail),
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
        stream: chatService.getMessages(senderID, widget.receiverID),
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
            controller: scrollController,
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
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.camera)),
          Expanded(
            child: CTextField(
              controller: messageController,
              hintText: 'Type a message',
              obscureText: false,
              focusNode: focusNode,
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
