import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_chat_app/components/search_textfield.dart';
import '../../controllers /services/auth/auth_service.dart';
import '../../controllers /services/chat/chat_service.dart';
import '../chat/chat_page.dart';
import '../home/users/user_tile.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search for friends'),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
        body: showSearchedusers());
  }

  Widget showSearchedusers() {
    return Column(
      children: [
        SearchTextField(
          hintText: 'Search',
          obscureText: false,
          controller: searchController,
          onChanged: (value) {
            chatService.searchUsers(value);
          },
        ),
        Expanded(
          child: Obx(() {
            if (chatService.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (searchController.value.text.isEmpty){
              return const Center(
                child: Text('Search for people to chat'),
              );
            }
            else if (chatService.searchResults.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            } 
            else {
              return ListView(
                children: chatService.searchResults
                    .map<Widget>((userData) => buildUserListItems(userData))
                    .toList(),
              );
            }
          }),
        ),
      ],
    );
  }

  Widget buildUserListItems(Map<String, dynamic> userData) {
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
