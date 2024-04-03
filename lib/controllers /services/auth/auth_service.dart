import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth  _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid
      });


      return userCredential;
    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }


  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid
      });
      return userCredential;
    } on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
  

  User? currentUser(){
    return _auth.currentUser;
  }



}