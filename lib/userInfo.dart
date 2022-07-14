import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getUserInfo{
  String? getUID(){
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();

    return uid;
  }

  String? getUName(){
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uname = user?.displayName.toString();

    return uname;
  }

  String? getUImg(){
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uimg = user?.photoURL.toString();

    return uimg;
  }

  String? getUEmail(){
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uemail = user?.email.toString();

    return uemail;
  }
}