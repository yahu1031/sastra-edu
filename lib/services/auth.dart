/*
 * Name: auth
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sastra_ebooks/services/user.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
  //       (FirebaseUser user) {
  //         user?.uid;
  //         user?.email;
  //       },
  //     );

  // SIGN UP
  Future<FirebaseUser> signUpUser(String _regNumber, String _password) async {
    try {
      FirebaseUser firebaseUser = await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: '$_regNumber@sastra.ac.in', password: _password)
          .then((authResult) => authResult.user);
      return firebaseUser;
    } catch (e) {
      return null;
    }
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  //Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    // print(user.email);
    return user != null ? User(user.uid, user.email, '', '', 1, '1') : null;
  }

  //auth change user Stream
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //Register User (Admin Only)
  Future registerWithEmailAndPassword(String _email, String _password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _email + "@sastra.ac.in", password: _password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(_email);
      print(_password);
    }
  }

  //Sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Singin with mail & password
  Future<FirebaseUser> signInWithEmailAndPassword(
      String _email, String _password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: _email + "@sastra.ac.in", password: _password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //SignOut
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Forgot Password
  Future resetPassword(String _email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: '$_email@sastra.ac.in');
  }
}
