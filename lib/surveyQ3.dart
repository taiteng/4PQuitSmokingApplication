import 'package:flutter/material.dart';
import 'surveyQ2.dart';
import 'package:numberpicker/numberpicker.dart';
import 'surveyQ4.dart';

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
      home: surveyQ3(),
    );
  }
}

class surveyQ3 extends StatefulWidget {

  @override
  State<surveyQ3> createState() => surveyQ3State();
}

class surveyQ3State extends State<surveyQ3> {
  int _currentValue = 3;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Question 3"),
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
                image: AssetImage("assets/images/surveyQ3.jpg"),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => surveyQ2()));
              },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => surveyQ4()));
              },
                icon: Icon(Icons.arrow_forward_ios_rounded),
                alignment: Alignment.centerRight,
              ),
            ],
          ),

          Divider(),
          Text("How many cigarrates do you smoke per day?",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(height:20.0),
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