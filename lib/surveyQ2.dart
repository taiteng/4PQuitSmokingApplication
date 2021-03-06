import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/surveyQ1.dart';
import 'surveyQ1.dart';
import 'package:numberpicker/numberpicker.dart';
import 'surveyQ3.dart';
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
      home: const SurveyQ2(),
    );
  }
}

class SurveyQ2 extends StatefulWidget {
  const SurveyQ2({Key? key}) : super(key: key);


  @override
  State<SurveyQ2> createState() => SurveyQ2State();
}

class SurveyQ2State extends State<SurveyQ2>{
  int _currentValue = 10;

  Future <void> quantityPerPack(String q2) async{
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();
    final surveyQuestion = FirebaseFirestore.instance.collection('surveys').doc(uid);
    await surveyQuestion.update({"quantityPerPack": q2});

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Question 2"),
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
                image: AssetImage("assets/images/surveyQ2.jpg"),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyQ1()));



              },
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              IconButton(onPressed: (){
                quantityPerPack(_currentValue.toString());
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyQ3()));

              },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                alignment: Alignment.centerRight,
              ),
            ],
          ),


          const Text("Quantity of the cigarettes per pack?",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: 250.0,
            child: NumberPicker(
              value: _currentValue,
              minValue: 0,
              maxValue: 20,
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