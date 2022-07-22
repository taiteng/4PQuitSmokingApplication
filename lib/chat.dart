import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userInfo.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

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
    DateTime now = DateTime.now();
    await _chat.add({"message": msg, "uid": getUserInfo().getUID().toString(), "uname": getUserInfo().getUName().toString(), "time": now});
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
          title: const Text('Community'),
          centerTitle: true,
        ),
        // Using StreamBuilder to display all products from Firestore in real-time
        body: Stack(
          children: [
            StreamBuilder(
              //stream: _chat.snapshots(),
              stream: FirebaseFirestore.instance.collection('chat').orderBy('time', descending: false).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10,bottom: 60),
                    itemBuilder: (context, index){
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      if(documentSnapshot["uid"]  != getUserInfo().getUID().toString()){
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
                                  Text(documentSnapshot["uname"], style: TextStyle(fontSize: 15),),
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
                                  Text(documentSnapshot["uname"], style: TextStyle(fontSize: 15),),
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        controller: _SendMessage,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      onPressed: () async{
                        FocusManager.instance.primaryFocus?.unfocus();

                        final String msg = _SendMessage.text;

                        if(msg == ""){
                          const snackBar = SnackBar(
                            content: Text('Please input smtg...'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }else{
                          _SendMessage.clear();
                          sendMessage(msg);
                        }

                      },
                    ),
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}