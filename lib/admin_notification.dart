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

  final _usernameController  = TextEditingController();
  final _titleController  = TextEditingController();
  final _descriptionController  = TextEditingController();

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState(){
    super.initState();
    _messaging.getToken().then((token) {
      storeToken(token);
    });

    requestPermission();
    loadFCM();
    listenFCM();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }


  void listenFCM() async{

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (message.notification != null) {
        final snackBar = SnackBar(
          content: Text(message.notification?.title ?? '', maxLines: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_launcher',

            ),
            iOS: IOSNotificationDetails(
              sound: 'default.wav',
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            )
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
    final String? uname = user?.displayName.toString();

    final _storeToken = FirebaseFirestore.instance.collection("deviceToken").doc(uname);
    await _storeToken.set({"deviceToken": token});
  }



  //Store the input notification from admin to firestore
  Future<void> publishNotification(String title, String desc,String username) async{
    await Firebase.initializeApp();

    // final _storeNotification = FirebaseFirestore.instance
    //     .collection("notification")
    //     .doc();
    //
    // await _storeNotification.set({"title": title, "description": desc});
    // print("Notification Created");

    DocumentSnapshot snapshot =
        (await FirebaseFirestore.instance.collection("deviceToken").doc("null").get()) as DocumentSnapshot<Object?>;

    String token = snapshot['deviceToken'];

    print(token);

    // final data = {
    //   'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
    //   'id': 1,
    //   'status': 'done',
    //   'message': title,
    // };
    //
    // try{
    //   http.Response response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
    //     'Content-Type': 'application/json',
    //     'Authorization': 'key=AAAAnGRnn1s:APA91bGVpUM9UDojflW5aNs3Z_Qcu8ZsRspmqOuZRDvh9jsTnKWfb2EbFUxNBiqLVWu-edtaXu_w6EjpHDDQqtu3BHPNRdlBAx48ofDe5XxbMnFP5xXn1PWbV7HT0i6gPg1VxHD-BC0E'
    // });
    //   body: jsonEncode(<String,dynamic>{
    //     'notification': <String,dynamic>{'title': title, 'body': 'hello'},
    //     'priority': 'high',
    //     'data': data,
    //     'to': token,
    //   });
    //
    //   if(response.statusCode == 200){
    //     print("Notification SUCCESS!!!");
    //   }else{
    //     print(response.statusCode);
    //     print("FAIL notification");
    //   }
    //
    // }catch(e){
    //   print(e);
    // }

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
              'body': desc,
              'title': title,
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

              //Specific User Container
              Container(
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'User',
                    border: OutlineInputBorder(),
                    hintText: "username...",
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),

              //Title Container
              Container(
                padding: EdgeInsets.only(top: 15),

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
                    final username = _descriptionController.text;
                    final title = _titleController.text;
                    final desc = _descriptionController.text;

                    if(title != "" && desc != ""){

                      publishNotification(title, desc, username); //Set to the firestore
                      _titleController.clear();
                      _descriptionController.clear();
                      _usernameController.clear();
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