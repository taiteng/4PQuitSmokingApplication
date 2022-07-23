import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'admin_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<DemoPage> {

  void getIsAdmin() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();

    DocumentSnapshot<Map<String, dynamic>> map = await FirebaseFirestore.instance.collection('user').doc(uid).get();
    final data = map.get("isAdmin");

    if(data.toString() == "true"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>adminMain()));
    }
    else{
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    getIsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Validation'),
            centerTitle: true,
          ),
        ),
    );
  }
  
}