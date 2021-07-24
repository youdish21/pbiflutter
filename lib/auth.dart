import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference().child("Users");

  AuthService._();

  static final AuthService _service = AuthService._();

  factory AuthService() => _service;


  //register with email & password
  // ignore: missing_return

  // ignore: missing_return


  // ignore: missing_return
  Future<User> createUserWithEmailAndPassword({
    String email,
    String password,
    String phone,
    String name,
  }) async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        // ignore: non_constant_identifier_names
        password: password,).then((Users){
          databaseReference.child(Users.user.uid).set({
            'PhoneNumber': phone, 'Name': name,});

      });

      return UserCredential.user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

    } catch (e) {

    }
  }
  //Sign in with email and Password

  // ignore: missing_return
  Future <User> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,

      );

      return UserCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {} else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.message ?? 'SignIn failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //sign in with phone number




  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Reset Password
  Future<void> sendPasswordResetEmail({
    String email,
  }) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
  // ignore: missing_return



  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

