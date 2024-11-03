import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // INSTANCE OF AUTH & FIRESTORE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // GET CURRENT USER
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  // SIGN IN
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );

      // SAVE USER INFO IF IT DOESN'T ALREADY EXIST
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
      );

      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

  // SIGN UP
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      // CREATE USER
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      // SAVE USER INFO IN A SEPARATE DOC
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
          );

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception (e.code);
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // ERRORS

}