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
  debugPrint('Handling a background message ${message.messageId}');
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
      home: const AdminMain(),
    );
  }
}

class AdminMain extends StatefulWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  State<AdminMain> createState() => AdminMainState();
}

class AdminMainState extends State<AdminMain>{
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final _usernameController  = TextEditingController();
  final _titleController  = TextEditingController();
  final _descriptionController  = TextEditingController();

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState(){
    super.initState();
    // _messaging.getToken().then((token) {
    //   storeToken(token);
    // });

    requestPermission();
    loadFCM();
    listenFCM();
  }

  // //Store the user's device token to the Firestore
  // Future<void> storeToken(String? token) async{
  //   await Firebase.initializeApp();
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   final String? uname = user?.displayName.toString();
  //
  //   final _storeToken = FirebaseFirestore.instance.collection("deviceToken").doc(uname);
  //   await _storeToken.set({"deviceToken": token});
  //
  //   debugPrint(token);
  // }
  void sendNotification({String? title, String? desc})async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);

        await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    AndroidNotificationChannel channel =
        const AndroidNotificationChannel(
            'high_channel',
            'High Importance Notification',
            description: "This channel is my channel",
            importance: Importance.max);

    flutterLocalNotificationsPlugin.show(0, title, desc, NotificationDetails(
      android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: 'ic_launcher',
      )
    ));
  }
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
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
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
  void listenFCM() async{



    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

        const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false
        );

        const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS
        );

        await flutterLocalNotificationsPlugin.initialize(initializationSettings);


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
            iOS: const IOSNotificationDetails(
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
        importance: Importance.max,
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

  //Store the input notification from admin to firestore
  void publishNotification(String title, String desc,String username) async{
    await Firebase.initializeApp();

    DocumentSnapshot snapshot =
        (await FirebaseFirestore.instance.collection("deviceToken").doc(username).get());

    String token = snapshot['deviceToken'];

    debugPrint(token);

    String tok = "cgPxYmWgQ-y3g9loWlJqMD:APA91bEa1Y0pxQ39fmGnPUHpfMlwBEstpVA7_D1G9pCk15iNZiIMNisrwBDEYvkNZvBr7y39bM6brlCxEPPcXWNxUD-T0gH8eXUvSlXg840-ltf9L8Q5l3ln4aFNxZyxYkX1sJNQB2ov";
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
            "to": tok,
          },
        ),
      );
    } catch (e) {
      debugPrint("error push notification");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tween - Push Notifications"),
        backgroundColor: Colors.red[600],
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[


              //Specific User Container
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,

                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'User',
                    border: OutlineInputBorder(),
                    hintText: "username...",
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),

              //Title Container
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(top: 15),

                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    hintText: "Maintenance, New Updates...",
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),


              //Description Container
              Container(
                padding: const EdgeInsets.only(top: 15),

                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
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
                padding: const EdgeInsets.only(top: 15),

                child: ElevatedButton.icon(
                  onPressed: () {
                    final username = _usernameController.text;
                    final title = _titleController.text;
                    final desc = _descriptionController.text;

                    if(title != "" && desc != ""){
                      publishNotification(title, desc, username); //Set to the FireStore
                      _titleController.clear();
                      _descriptionController.clear();
                      _usernameController.clear();
                    }else{
                      debugPrint("Title and Description might be empty?");
                    }

                  },
                  icon: const Icon(Icons.send, size: 18),
                  label: const Text("Send"),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
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