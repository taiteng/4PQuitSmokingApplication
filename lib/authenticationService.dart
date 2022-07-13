import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class authenticationService{
  final FirebaseAuth _firebaseAuth;

  authenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn(String email, String password) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    }on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String?> signUp(String email, String password) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    }on FirebaseAuthException catch (e){
      return e.message;
    }
  }


}