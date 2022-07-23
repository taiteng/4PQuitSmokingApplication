import 'dart:async';
import 'userInfo.dart';
import 'admin_main.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminA extends StatelessWidget {
  const AdminA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: AAPage(),
    );
  }
}

class AAPage extends StatefulWidget {
  const AAPage({Key? key}) : super(key: key);

  @override
  _AAState createState() => _AAState();
}

class _AAState extends State<AAPage> {
  // text fields' controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();

  final CollectionReference _achievements = FirebaseFirestore.instance.collection('achievements');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _titleController.text = documentSnapshot['title'].toString();
      _descController.text = documentSnapshot['desc'].toString();
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

                        // Show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Achievement added')));
                      }

                      if (action == 'update') {
                        // Update the product
                        await _achievements
                            .doc(documentSnapshot!.id)
                            .update({"title": title, "desc": desc, "condition": condition});

                        // Show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Achievement updated')));
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descController.text = '';
                      _conditionController.text = '';

                      // Hide the bottom sheet
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Please make sure you fill in the field'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>adminMain())),
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
                  if(document['condition'] > 0){
                    return Card(
                      elevation: 3.0,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(document['title'], style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                          Text(document['desc'], style: TextStyle(color: Colors.black54,),),
                          SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                // Press this button to edit a single product
                                IconButton(
                                    icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    const snackBar = SnackBar(
                                      content: Text('Button edit achievement pressed'),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                    _createOrUpdate(document);
                                  },
                                  key: const ValueKey("edit_btn"),
                                ),
                                // This icon button is used to delete a single product
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    const snackBar = SnackBar(
                                      content: Text('Button delete achievement pressed'),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar);

                                    _deleteProduct(document.id);
                                  },
                                  key: const ValueKey("dlt_btn"),
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
          onPressed: () async {
            const snackBar = SnackBar(
              content: Text('Button add achievement pressed'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            _createOrUpdate();
          },
          child: const Icon(Icons.add),
          key: const ValueKey("add_btn"),
        ),
      ),
    );
  }
}