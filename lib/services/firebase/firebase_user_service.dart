import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wei_inventory_firebase/models/user.dart';

class FirebaseUserService {
  static Future<User> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString("user_id") == null) {
      return null;
    }

    final User result = User(
      firstName: preferences.getString("user_first_name"),
      secondName: preferences.getString("user_second_name"),
      email: preferences.getString("user_email")
    );
    result.id = preferences.getString("user_id");

    return result;
  }

  static Future<bool> registerUser(User user, String password) async {
    final CollectionReference usersCollectionReference = Firestore.instance.collection("users");
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final FirebaseUser firebaseUser = (await auth.createUserWithEmailAndPassword(
        email: user.email, 
        password: password
      )).user;

      if (firebaseUser != null) {
        user.id = firebaseUser.uid;

        await firebaseUser.sendEmailVerification();
        await usersCollectionReference.document(user.id).setData(user.toJson());
      }
    } on PlatformException {
      return false;
    }

    return true;
  }

  static Future<User> loginUser(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final CollectionReference usersCollectionReference = Firestore.instance.collection("users");

    final FirebaseUser firebaseUser = (await auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    )).user;

    if (firebaseUser != null && firebaseUser.isEmailVerified) {
      final Completer<User> completer = Completer<User>();

      usersCollectionReference.document(firebaseUser.uid).snapshots().listen((snapshot) {
        completer.complete(User.fromSnapshot(snapshot));
      });

      final User loggedUser = await completer.future;

      preferences.setString("user_id", loggedUser.id);
      preferences.setString("user_first_name", loggedUser.firstName);
      preferences.setString("user_second_name", loggedUser.secondName);
      preferences.setString("user_email", loggedUser.email);

      return loggedUser;
    }

    return null;
  }

  static Future logOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("user_id", null);
    preferences.setString("user_first_name", null);
    preferences.setString("user_second_name", null);
    preferences.setString("user_email", null);
  }
}