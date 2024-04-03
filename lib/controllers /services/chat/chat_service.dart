import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserList(){
    return _firestore.collection('Users').snapshots().map((snapshot) 
      => snapshot.docs.map((doc) => doc.data()).toList());
  }


}