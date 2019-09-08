import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurent_app/login/LoginAuth.dart';
import 'package:restaurent_app/model/user.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> createUser(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
  Future<bool> authenticateUser(FirebaseUser user);
  Future<void> addToDb(FirebaseUser currentUser);
}

class Auth implements BaseAuth {
  LoginAuth loginAuth = LoginAuth();
  User user = User();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<FirebaseUser> createUser(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    return docs.length == 0 ? true : false;
  }

  Future<void> addToDb(FirebaseUser currentUser) async {
    user = User(
        uid: currentUser.uid,
        email: currentUser.email,
        phone: LoginAuth.phone,
        address: LoginAuth.address,
        username: currentUser.email);

    Firestore.instance
        .collection('users')
        .document(currentUser.email)
        .setData(user.toMap(user));
  }
}
