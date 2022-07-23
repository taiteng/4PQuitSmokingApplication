import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'surveyQ3.dart';
import 'package:flutter/cupertino.dart';
import 'endSurvey.dart';
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
      home: const SurveyQ4(),
    );
  }
}

class SurveyQ4 extends StatefulWidget {
  const SurveyQ4({Key? key}) : super(key: key);


  @override
  State<SurveyQ4> createState() => SurveyQ4State();
}

class SurveyQ4State extends State<SurveyQ4> {
  DateTime selectedDate = DateTime.now();

  Future  <void> quitSmokingDate(String q4) async{
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();
    final surveyQuestion = FirebaseFirestore.instance.collection('surveys').doc(uid);
    await surveyQuestion.update({"quitSmokingDate": q4});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Question 4"),
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
                image: AssetImage("assets/images/surveyQ4.jpg"),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyQ3()));
              },
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
              IconButton(onPressed: (){
                String trimDate = selectedDate.toString().substring(0, 10);
                quitSmokingDate(trimDate);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => endSurvey()));

                },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                alignment: Alignment.centerRight,
              ),
            ],
          ),

          const Divider(),
          const Text("When do you plan to quit smoking?",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height:20.0),
          SizedBox(width: 250.0,
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                },
              ),
            ),
            ),
        ],
      ),
    ),
    );
  }
}