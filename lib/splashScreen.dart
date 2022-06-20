import 'dart:async';
import 'package:flutter/material.dart';
import 'surveyQ1.dart';
import 'loginScreen.dart';

void main() {
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
      home: SplashScreen(),
      //home:  MyHomePage(title: 'Quit Smoking App'),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> loginScreen()));
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
            SizedBox(height: 20,),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Quit Smoking"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
