import 'package:flutter/material.dart';
import 'surveyQ3.dart';
import 'package:flutter/cupertino.dart';
import 'endSurvey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: surveyQ4(),
    );
  }
}

class surveyQ4 extends StatefulWidget {

  @override
  State<surveyQ4> createState() => surveyQ4State();
}

class surveyQ4State extends State<surveyQ4> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Question 4"),
        backgroundColor: Colors.red[600],
        automaticallyImplyLeading: false,
      ),
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[

          Container(
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/surveyQ4.jpg"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.horizontal(),
            ),
          ),

          SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => surveyQ3()));
              },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => endSurvey()));
              },
                icon: Icon(Icons.arrow_forward_ios_rounded),
                alignment: Alignment.centerRight,
              ),
            ],
          ),

          Divider(),
          Text("When do you plan to quit smoking?",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(height:20.0),
          SizedBox(width: 250.0,
            child: Container(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(1950, 1, 1),
                onDateTimeChanged: (DateTime newDateTime) {
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