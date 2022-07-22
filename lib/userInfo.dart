import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class getUserInfo{
  final User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference _surveyInfo = FirebaseFirestore.instance.collection('surveys');

  String? getUID(){
    final String? uid = user?.uid.toString();

    return uid;
  }

  String? getUName(){
    final String? uname = user?.displayName.toString();

    return uname;
  }

  String? getUsername(String userID){
    return userID;
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

  Future<String> displayTime() async {
    final String? uid = user?.uid.toString();
    var data;
    var docRef = FirebaseFirestore.instance.collection("surveys").doc(uid);
    await docRef.get().then((value) => data = value.get('time'));

    int time = 0;
    int secs = 0;
    int mins = 0;
    int hours = 0;
    int days = 0;
    int months = 0;
    int temp = 0;

    String uTime = data.toString();
    var timeParts = uTime.split(":");

    if(timeParts[0] != "00"){
      temp = int.parse(timeParts[0]);
      days = temp * 1440;
      time += days;
    }
    else if(timeParts[1] != "00"){
      temp = int.parse(timeParts[1]);
      hours = temp * 60;
      time += hours;
    }
    else if(timeParts[2] != "00"){
      mins = int.parse(timeParts[2]);
      time += mins;
    }
    else if(timeParts[3] != "00"){
      temp = int.parse(timeParts[3]);
      secs = (temp/60) as int;
      time += secs;
    }
    else{
      time += 0;
    }

    return time.toString();
  }
}