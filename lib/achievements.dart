import 'dart:async';
import 'userInfo.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: APage(),
    );
  }
}

class APage extends StatefulWidget {
  const APage({Key? key}) : super(key: key);

  @override
  _AState createState() => _AState();
}

class _AState extends State<APage> {
  final CollectionReference _achievements = FirebaseFirestore.instance.collection('achievements');

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Tween'))),
          ),
          title: const Text('Achievements'),
          centerTitle: true,
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: StreamBuilder(
          stream: _achievements.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1,
                children: streamSnapshot.data!.docs.map((document) {
                  if(document['condition'] > 20){
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(document['title'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                          Text(document['desc'], style: TextStyle(color: Colors.black54,),),
                        ],
                      ),
                    );
                  }
                  else{
                    return SizedBox.shrink();
                  }
                }).toList(),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}