import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FireBaseAuthProvider {
  Future signupwithemailandpassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final responce = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return responce;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return e.toString();
    }
  }

  Future checkcurrentuser() async {
    try {
      final responce = FirebaseAuth.instance.currentUser;
      if (kDebugMode) {
        print('the current user is $responce');
      }
      return responce;
    } catch (e) {
      return e.toString();
    }
  }
}
