import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage{
  String username;
  String messageContent;
  String messageType;
  ChatMessage({required this.username, required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(username: "E Soon", messageContent: "Hi", messageType: "sender"),
  ChatMessage(username: "David", messageContent: "How r u", messageType: "receiver"),
];

Future displayMessages() async {
  String sender = "sender";
  String receiver = "receiver";

  FirebaseFirestore.instance.collection('chat').get().then((value) {
    value.docs.forEach((result) {
      String msg = result.get("message").toString();
      String uid = result.get("uid").toString();
      print(uid);

      if(uid == "z9KAl1swgqbtdk1BOEMPIUVVRyz1"){
        ChatMessage chat = new ChatMessage(username: "E Soon", messageContent: msg, messageType: sender);
        messages.add(chat);
      }
      else{
        ChatMessage chat = new ChatMessage(username: "David", messageContent: msg, messageType: receiver);
        messages.add(chat);
      }
    },
    );
  },
  );
}