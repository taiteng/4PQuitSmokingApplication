import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'surveyQ2.dart';
import 'package:numberpicker/numberpicker.dart';
import 'surveyQ4.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async{
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SurveyQ3(),
    );
  }
}

class SurveyQ3 extends StatefulWidget {
  const SurveyQ3({Key? key}) : super(key: key);


  @override
  State<SurveyQ3> createState() => SurveyQ3State();
}

class SurveyQ3State extends State<SurveyQ3> {
  int _currentValue = 3;

  Future  <void> cigarattesPerDay(String q3) async{
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();
    final surveyQuestion = FirebaseFirestore.instance.collection('surveys').doc(uid);
    await surveyQuestion.update({"cigarattesPerDay": q3});
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Question 3"),
        backgroundColor: Colors.red[600],
        automaticallyImplyLeading: false,
      ),
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[

          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/surveyQ3.jpg"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.horizontal(),
            ),
          ),

          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyQ2()));
              },
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              IconButton(onPressed: (){
                cigarattesPerDay(_currentValue.toString());
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyQ4()));

                },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                alignment: Alignment.centerRight,
              ),
            ],
          ),

          const Divider(),
          const Text("How many cigarettes do you smoke per day?",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height:20.0),
          SizedBox(width: 250.0,
            child: NumberPicker(
              value: _currentValue,
              minValue: 0,
              maxValue: 30,
              onChanged: (value) => setState(() => _currentValue = value),
            ),
          ),
          Text('Current value: $_currentValue'),

        ],
      ),
    ),
    );
  }
}