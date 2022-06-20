import 'package:flutter/material.dart';
import 'package:quit_smoking/surveyQ1.dart';
import 'surveyQ1.dart';
import 'package:numberpicker/numberpicker.dart';
import 'surveyQ3.dart';

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
      home: surveyQ2(),
    );
  }
}

class surveyQ2 extends StatefulWidget {

  @override
  State<surveyQ2> createState() => surveyQ2State();
}

class surveyQ2State extends State<surveyQ2> with AutomaticKeepAliveClientMixin<surveyQ2>{
  int _currentValue = 10;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Question 2"),
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
                image: AssetImage("assets/images/surveyQ2.jpg"),
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => surveyQ1()));



              },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => surveyQ3()));
              },
                icon: Icon(Icons.arrow_forward_ios_rounded),
                alignment: Alignment.centerRight,
              ),
            ],
          ),


          Text("Quantity of the cigarattes per pack?",
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
  @override
  bool get wantKeepAlive => true;
}