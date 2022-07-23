import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  FToast fToast = FToast();

  _button() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Add button pressed"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  _notPRO() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("You are not a PRO user"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  _created() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Achievement created"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  _empty() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Please make sure you fill in the field"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  // text fields' controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();

  final CollectionReference _achievements = FirebaseFirestore.instance.collection('achievements');
  final CollectionReference _user = FirebaseFirestore.instance.collection('user');
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  key: const ValueKey("txt_title"),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  key: const ValueKey("txt_desc"),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _conditionController,
                  decoration: const InputDecoration(
                    labelText: 'Condition',
                  ),
                  key: const ValueKey("txt_condition"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Create'),
                  onPressed: () async {
                    final String? title = _titleController.text;
                    final String? desc = _descController.text;
                    final int? condition =
                    int.tryParse(_conditionController.text);
                    if (title != null && desc != null && condition != null) {
                      await _achievements.add({"title": title, "desc": desc, "condition": condition});

                      _created();

                      // Clear the text fields
                      _titleController.text = '';
                      _descController.text = '';
                      _conditionController.text = '';

                      // Hide the bottom sheet
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                    else{
                      _empty();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
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
                  return FutureBuilder(
                      future: getUserInfo().displayTime(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        String data = snapshot.data;
                        int time = int.parse(data);
                        if(document['condition'] < time){
                          return Card(
                            elevation: 3.0,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(document['title'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                                Text(document['desc'], style: TextStyle(color: Colors.black54,),),
                                //Text(snapshot.data.toString(), style: TextStyle(color: Colors.black54,),),
                              ],
                            ),
                          );
                        }
                        else{
                          return SizedBox.shrink();
                        }
                      },
                    );
                }).toList(),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // Add new product
        floatingActionButton: FutureBuilder(
          future: getUserInfo().getIsPro(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            bool data = snapshot.data;
            if(data){
              return FloatingActionButton(
                onPressed: () async{
                  _button();

                  _create();
                },
                child: const Icon(Icons.add),
                key: const ValueKey("add_btn"),
              );
            }
            else{
              return FloatingActionButton(
                onPressed: () async{
                  _notPRO();
                },
                child: const Icon(Icons.add),
                key: const ValueKey("add_btn"),
              );
            }
          }
        ),
      ),
    );
  }
}