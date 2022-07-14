import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  final _SendMessage = TextEditingController();

  final CollectionReference _chat =
  FirebaseFirestore.instance.collection('chat');

  Future<void> sendMessage(String msg) async{
    await Firebase.initializeApp();
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();
    final String? uname = user?.displayName.toString();

    await _chat.add({"message": msg, "uid": uid, "uname": uname});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Tween'))),
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://assets4.lottiefiles.com/packages/lf20_ik4jyixs.json"),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Community",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(messages[index].username, style: TextStyle(fontSize: 15),),
                        Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                      ],
                    ),
                  ),
                ),
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
                      final String msg = _SendMessage.text;

                      if(msg == ""){
                        const snackBar = SnackBar(
                          content: Text('Please input smtg...'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
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
    );
  }
}