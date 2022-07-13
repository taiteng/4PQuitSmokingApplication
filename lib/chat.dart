import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),


];

displayMessages(){
  FirebaseFirestore.instance.collection('chat').get().then((value) {
    value.docs.forEach((result) {
      print(result.get("uid"));
      if(result.get("uid") == "z9KAl1swgqbtdk1BOEMPIUVVRyz1"){
        ChatMessage(messageContent: result.get('message'), messageType: "receiver");
      }
      else{
        ChatMessage(messageContent: result.get('message'), messageType: "sender");
      }
    },
    );
  },
  );
}