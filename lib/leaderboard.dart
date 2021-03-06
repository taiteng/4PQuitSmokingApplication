import 'package:quit_smoking/userInfo.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: LPage(),
    );
  }
}

class LPage extends StatefulWidget {
  const LPage({Key? key}) : super(key: key);

  @override
  _LState createState() => _LState();
}

class _LState extends State<LPage> {
  final CollectionReference _achievements =
  FirebaseFirestore.instance.collection('surveys');

  int count = 0;

  int plusCount(count){
    count++;

    return count;
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            //onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Tween'))),
            onPressed: ()=>Navigator.pop(context),
          ),
          title: const Text('Leaderboard'),
          centerTitle: true,
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('surveys').orderBy('time', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisCount: 1,
                childAspectRatio: 5,
                children: streamSnapshot.data!.docs.map((document) {
                  return GestureDetector(
                    child: Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(plusCount(count).toString(), style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                          Text(document['username'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                          Text(document['time'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),
                  );
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