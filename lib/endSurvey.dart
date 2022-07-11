import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';

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
      home: endSurvey(),
    );
  }
}

class endSurvey extends StatefulWidget {

  @override
  State<endSurvey> createState() => endSurveyState();
}

class endSurveyState extends State<endSurvey> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Tween"),
        backgroundColor: Colors.red[600],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Text("Thank you for Completing the Survey",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),

              ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: 'Tween')));
            },
                child: Text("Proceed",
                style: TextStyle(
                  fontSize: 20,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}