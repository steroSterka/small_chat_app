import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:small_chat_app/controllers%20/services/auth/auth_service.dart';
import 'package:small_chat_app/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Stream<List<Map<String, dynamic>>> getUserList() {
    return _firestore
        .collection('Users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserEmail = _authService.currentUser()!.email!;
    final String currentUserID = _authService.currentUser()!.uid;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // void searchUsers(String searchEmail) {
  //   _firestore.collection('Users').where('email', isEqualTo: searchEmail).get().then((snapshot) {
  //     searchResults.value = snapshot.docs.map((doc) => doc.data()).toList();
  //   });
  // }



  var isLoading = false.obs;

  void searchUsers(String searchEmail) {
    isLoading.value = true;
    _firestore
        .collection('Users')
        .orderBy('email')
        .startAt([searchEmail])
        .endAt(['$searchEmail\uf8ff'])
        .get()
        .then((snapshot) {
          searchResults.value = snapshot.docs.map((doc) => doc.data()).toList();
                    isLoading.value = false;

        });
  }

  var searchResults = [].obs;
}
