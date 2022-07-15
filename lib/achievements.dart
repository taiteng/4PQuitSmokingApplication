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
  // text fields' controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();

  bool isPro = false;

  final CollectionReference _achievements = FirebaseFirestore.instance.collection('achievements');

  void _notValidated() {
    const snackBar = SnackBar(
      content: Text('You are not a PRO user.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _titleController.text = documentSnapshot['title'].toString();
      _conditionController.text = documentSnapshot['desc'].toString();
      _conditionController.text = documentSnapshot['condition'].toString();
    }

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
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _conditionController,
                  decoration: const InputDecoration(
                    labelText: 'Condition',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? title = _titleController.text;
                    final String? desc = _descController.text;
                    final int? condition =
                    int.tryParse(_conditionController.text);
                    if (title != null && desc != null && condition != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _achievements.add({"title": title, "desc": desc, "condition": condition});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _achievements
                            .doc(documentSnapshot!.id)
                            .update({"title": title, "desc": desc, "condition": condition});
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descController.text = '';
                      _conditionController.text = '';

                      // Hide the bottom sheet
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String aId) async {
    await _achievements.doc(aId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted an achievement')));
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
                          //Text(document['condition'], style: TextStyle(color: Colors.black54,),),
                          SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                // Press this button to edit a single product
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => isPro?_createOrUpdate(document):_notValidated(),
                                ),
                                // This icon button is used to delete a single product
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => isPro?_deleteProduct(document.id):_notValidated(),
                                ),
                              ],
                            ),
                          ),
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
        // Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => isPro?_createOrUpdate():_notValidated(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}