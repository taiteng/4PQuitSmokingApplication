import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getUserInfo{
  final User? user = FirebaseAuth.instance.currentUser;

  String? getUID(){
    final String? uid = user?.uid.toString();

    return uid;
  }

  String? getUName(){
    final String? uname = user?.displayName.toString();

    return uname;
  }

  String? getUImg(){
    final String? uimg = user?.photoURL.toString();

    return uimg;
  }

  String? getUEmail(){
    final String? uemail = user?.email.toString();

    return uemail;
  }

  bool getIsPro(){
    //bool isPro = FirebaseFirestore.instance.collection('users').doc(user?.uid.toString()).collection('isPro').get() as bool;
    //final bool? isPro = user?.isPro;

    // if(isPro == true){
    //   return true;
    // }
    // else{
    //   return false;
    // }
    return true;
  }

  bool getIsAdmin(){
    //bool isAdmin = FirebaseFirestore.instance.collection('users').doc(user?.uid.toString()).collection('isAdmin').get() as bool;
    //final bool? isAdmin = user?.isAdmin;

    // if(isAdmin == true){
    //   return true;
    // }
    // else{
    //   return false;
    // }
    return true;
  }
}