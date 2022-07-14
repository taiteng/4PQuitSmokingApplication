import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatPage> {
  final _SendMessage = TextEditingController();

  final CollectionReference _chat =
  FirebaseFirestore.instance.collection('chat');

  Future<void> sendMessage(String msg) async{
    await Firebase.initializeApp();
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();

    await _chat.add({"message": msg, "uid": uid});
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
          title: const Text('Community'),
          centerTitle: true,
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: StreamBuilder(
          stream: _chat.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              final User? user = FirebaseAuth.instance.currentUser;
              final String? uid = "z9KAl1swgqbtdk1BOEMPIUVVRyz1";
              final String uname = "E Soon";
              //user?.displayName.toString();
              //user?.uid.toString();
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  if(documentSnapshot["uid"]  != uid){
                    return Container(
                      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child: Align(
                        alignment: (Alignment.topLeft),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (Colors.grey.shade200),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(uname, style: TextStyle(fontSize: 15),),
                              Text(documentSnapshot["message"], style: TextStyle(fontSize: 15),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child: Align(
                        alignment: (Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (Colors.blue[200]),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(uname, style: TextStyle(fontSize: 15),),
                              Text(documentSnapshot["message"], style: TextStyle(fontSize: 15),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
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