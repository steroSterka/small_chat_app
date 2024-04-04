import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:small_chat_app/components/search_textfield.dart';
import 'package:small_chat_app/controllers%20/services/auth/auth_service.dart';
import 'package:small_chat_app/controllers%20/services/chat/chat_service.dart';
import 'package:small_chat_app/pages/chat/chat_page.dart';
import 'package:small_chat_app/pages/home/drawer/drawer.dart';
import 'package:small_chat_app/pages/home/users/user_tile.dart';
import 'package:small_chat_app/pages/login/widgets/login_textfield.dart';
import 'package:small_chat_app/pages/search/search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final RxList<Map<String, dynamic>> users = chatService.users.obs;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          actions: [
            IconButton(
                  icon: const Icon(Iconsax.search_favorite),
                  onPressed: ()  => Get.to(()=>  SearchPage())
                )
          ],
        ),
        drawer: const CDrawer(),
        body: buildUserList());
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: chatService.getUserList(),
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
            children: snapshot.data!
                .map<Widget>(
                    (userData) => buildUserListItems(userData, context))
                .toList());
      },
    );
  }

  Widget buildUserListItems(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.currentUser()!.email) {
      return UserTile(
          text: userData["email"],
          onTap: () => Get.to(() => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              )));
    }
    return const SizedBox();
  }

}
