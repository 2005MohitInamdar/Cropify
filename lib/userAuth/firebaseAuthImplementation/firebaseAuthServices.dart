import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../global/common/toast.dart';

class FireBaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to create user  with email and password
  Future<User?> createUserWithEmailAndPassword(String email,
      String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await _firestore.collection("Users").doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use'){
        showToast(message: 'The email address is already in use by another account.');
      } else if (e.code == 'weak-password') {
        showToast(message: 'The password provided is too weak.');
      }  else {
        showToast(message: 'FirebaseAuthException: ${e.message}');
      }
    }
    catch (e) {
      showToast(message: 'An error occurred: $e');
    }


    return null;
  }


// Method to sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      // Create a new user using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _firestore.collection("Users").doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
        });
      }


      // Return the newly created user
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific authentication errors
      if (e.code == 'user-not-found') {
        showToast(message: 'Invalid Email.');
      } else if (e.code == 'wrong-password') {
        showToast(message: 'Wrong Password.');
      }  else {
        showToast(message: 'FirebaseAuthException: ${e.message}');
      }
    }

    catch (e) {
      // Handle any other errors
      showToast(message: 'An error occurred: $e');
    }
    return null; // Return null if sign-up fails
  }

}