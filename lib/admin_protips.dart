import 'main.dart';
import 'admin_main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AdminP());
}

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

  FToast fToast = FToast();

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
          Text("Pro tip created"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  _editted() {
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
          Text("Pro tip updated"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  _deleted() {
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
          Text("Pro tip deleted"),
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

  _button(String type) {
    Widget toast = SizedBox.shrink();

    if(type == "add"){
      toast = Container(
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
    }
    else if(type == "edit"){
      toast = Container(
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
            Text("Edit button pressed"),
          ],
        ),
      );
    }
    else{
      toast = Container(
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
            Text("Delete button pressed"),
          ],
        ),
      );
    }


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  final CollectionReference _protips =
  FirebaseFirestore.instance.collection('protips');

  // text fields' controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _titleController.text = documentSnapshot['title'].toString();
      _descController.text = documentSnapshot['desc'].toString();
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
                  key: const ValueKey("txt_title"),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  key: const ValueKey("txt_desc"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? title = _titleController.text;
                    final String? desc = _descController.text;
                    if (title != null && desc != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _protips.add({"title": title, "desc": desc});

                        _created();
                      }

                      if (action == 'update') {
                        // Update the product
                        await _protips
                            .doc(documentSnapshot!.id)
                            .update({"title": title, "desc": desc});

                        _editted();
                      }

                      // Clear the text fields
                      _titleController.text = '';
                      _descController.text = '';

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

  // Deleteing a product by id
  Future<void> _deleteProduct(String aId) async {
    await _protips.doc(aId).delete();

    _deleted();
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
             onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>adminMain())),
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
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Press this button to edit a single product
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                _button("edit");

                                _createOrUpdate(documentSnapshot);
                              },
                              key: const ValueKey("edit_btn"),
                            ),
                            // This icon button is used to delete a single product
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async{
                                _button("delete");

                                _deleteProduct(documentSnapshot.id);
                              },
                              key: const ValueKey("dlt_btn"),
                            ),
                          ],
                        ),
                      ),
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
        // Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _button("add");

            _createOrUpdate();
          },
          child: const Icon(Icons.add),
          key: const ValueKey("add_btn"),
        ),
      ),
    );
  }
}