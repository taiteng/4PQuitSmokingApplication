import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: adminMain(),
    );
  }
}

class adminMain extends StatefulWidget {
  @override
  State<adminMain> createState() => adminMainState();
}

class adminMainState extends State<adminMain>{
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _titleController  = TextEditingController();
  final _descriptionController  = TextEditingController();

  final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState(){
    super.initState();

    loadFCM();
    listenFCM();

    _messaging.getToken().then((token) {
      storeToken(token);
    });
    
    //FirebaseMessaging.instance.subscribeToTopic("topic");
  }

  void listenFCM() async{
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_launcher',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async{
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }



  //Store the user's device token to the Firestore
  Future<String?> storeToken(String? token) async{
    await Firebase.initializeApp();
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();

    print(token);

    final _storeToken = FirebaseFirestore.instance.collection("deviceToken").doc("token");
    await _storeToken.set({"deviceToken": token});
  }



  //Store the input notification from admin to firestore
  Future<void> publishNotification(String title, String desc) async{
    await Firebase.initializeApp();

    final _storeNotification = FirebaseFirestore.instance
        .collection("notification")
        .doc();

    await _storeNotification.set({"title": title, "description": desc});
    print("Notification Created");

    DocumentSnapshot snapshot =
        (await FirebaseFirestore.instance.collection("deviceToken").doc("token").get()) as DocumentSnapshot<Object?>;

    String token = snapshot['deviceToken'];

    print(token);

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAnGRnn1s:APA91bHE1CCtOEcMTWzEdUvwwVAaSvqyhvY6luVjHvaIbqjUyx42jjxp6nNSpL2fmaRjff-X0lXc5nNtoMB8e847V2HxU8QeGlyqO-LGiWyJ-iKoig71QoD_djIcT-Jp8Z5IzJo3TH2h',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Test ',
              'title': 'Test Title'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tween - Push Notifications"),
        backgroundColor: Colors.red[600],
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[



              //Title Container
              Container(
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    hintText: "Maintainance, New Updates...",
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),


              //Description Container
              Container(
                padding: EdgeInsets.only(top: 15),

                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    hintText: "There will be a new updates in the upcoming months....",
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: EdgeInsets.only(top: 15),

                child: ElevatedButton.icon(
                  onPressed: () async{
                    final title = _titleController.text;
                    final desc = _descriptionController.text;

                    if(title != "" && desc != ""){

                      publishNotification(title, desc); //Set to the firestore
                      _titleController.clear();
                      _descriptionController.clear();
                    }else{
                      print("Title and Description might be empty?");
                    }

                  },
                  icon: Icon(Icons.send, size: 18),
                  label: Text("Send"),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}