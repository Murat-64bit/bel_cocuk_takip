import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bel_cocuk_takip/models/user.dart' as model;
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //signup user
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required String parentPhone,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          parentPhone.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        // add user database
        model.User user = model.User(
          uid: cred.user!.uid,
          name: name,
          email: email,
          parentPhone: parentPhone,
          point: 0,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'succes';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = await _auth.currentUser;
    firebaseUser?.updatePassword(password);
  }

  Future<void> updateMail(String email) async {
    var firebaseUser = await _auth.currentUser;
    firebaseUser?.updateEmail(email);
  }
}
