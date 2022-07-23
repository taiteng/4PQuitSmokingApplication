import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/main.dart';
import 'loginScreen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      //home:  MyHomePage(title: 'Quit Smoking App'),
    );
  }
}

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  initState()  {

    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Timer(const Duration(seconds:3),()
        {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => loginScreen()));
        });
       } else {
        Timer(const Duration(seconds:3),(){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> const MyHomePage(title: 'Login',) ), (route) => false);
        });
      }
    });

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.red[600],
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Image.asset('assets/images/quit-smoking.jpg', height: 120,),
            const SizedBox(height: 20,),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}


