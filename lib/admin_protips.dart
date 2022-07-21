import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminP extends StatelessWidget {
  const AdminP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: APPage(),
    );
  }
}

class APPage extends StatefulWidget {
  const APPage({Key? key}) : super(key: key);

  @override
  _APState createState() => _APState();
}

class _APState extends State<APPage> {
  final CollectionReference _protips =
  FirebaseFirestore.instance.collection('protips');

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
          title: const Text('Pro Tips'),
          centerTitle: true,
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: StreamBuilder(
          stream: _protips.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['title']),
                      subtitle: Text(documentSnapshot['desc']),
                    ),
                  );
                },
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