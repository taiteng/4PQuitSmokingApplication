import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'NavBar.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Side Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tween'),
    );
  }


}





class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[500],
      drawer:  NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text(widget.title),
        centerTitle: true,

      ),




      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[

              Container(
                color: Colors.lightBlue,
                width: 400,
                height: 100,

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[
                      Text('  Money Saved \n\n \t\t\t\t\t\t\t\t\t 0',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight. bold,
                        ),
                      ),
                      Lottie.network('https://assets8.lottiefiles.com/packages/lf20_i0mxtka6.json',width: 110,height: 110),
                      Text('Total Achivement \n\n \t\t\t\t\t\t\t\t\t\t\t\t\t 0',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight. bold,
                        ),
                      ),
                  ],
                ),
              ),

            SizedBox(height: 20),

            Container(
              color: Colors.purple,
              width: 390,
              height: 100,

              child: Row(

                children: <Widget>[

                  Text('    Life Won \n\n \t\t\t\t\t\t 0',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\tCigarettes Ignored \n\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t 0',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20),

            Container(
              color: Colors.yellow,
              width: 420,
              height: 50,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Text('You have stopped smoking for',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight. bold,
                      ),
                    ),
                ],
              ),
            ),


            Container(
              color: Colors.yellow,
              width: 420,
              height: 50,

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                children: <Widget>[
                  Text('0',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('0',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('0',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),

                ],
              ),
            ),


            Container(
              color: Colors.yellow,
              width: 420,
              height: 50,

              child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                children: <Widget>[
                  Text('     Days',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('Hours',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('Minutes',textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Icon(Icons.share),
                ],
              ),
            ),

            SizedBox(height: 20),

            Container(
              color: Colors.lightGreenAccent,
              width: 420,
              height: 25,


              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  Text('Achivement              \n\n \t\t\t\t\t\t\t\t\t',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('                 See More \n\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                ],
              ),

            ),


            Container(
              color: Colors.lightGreenAccent,
              width: 420,
              height: 50,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  Text('XXXXXXXXXXXXXXXXXXXXXXXXX',
                    style: TextStyle(
                      fontSize: 20,
                      backgroundColor: Colors.red[100]
                    ),
                  ),
                  Icon(Icons.share),
                ],
              ),
            ),

            Container(
              color: Colors.lightGreenAccent,
              width: 420,
              height: 50,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  Text('XXXXXXXXXXXXXXXXXXXXXXXXX',
                    style: TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.red[100]
                    ),
                  ),
                  Icon(Icons.share),
                ],
              ),
            ),

            Container(
              color: Colors.lightGreenAccent,
              width: 420,
              height: 50,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  Text('XXXXXXXXXXXXXXXXXXXXXXXXX',
                    style: TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.red[100]
                    ),
                  ),
                  Icon(Icons.share),
                ],
              ),
            ),


            SizedBox(height: 20),


            Container(
              color: Colors.pink,
              width: 420,
              height: 25,


              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  Text('Pro Tips                     \n\n \t\t\t\t\t\t\t\t\t',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                  Text('                 See More \n\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                ],
              ),
            ),


            Container(
              color: Colors.pink,
              width: 420,
              height: 50,


              child:Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  Text('XXXXXXXXXXXXXXXXXXXXXXXXXX',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.share),
                ],
              ),
            ),


            SizedBox(height: 20),


            Container(
              color: Colors.orange,
              width: 420,
              height: 150,

              child: Row(
                children: <Widget>[
                  Lottie.network('https://assets4.lottiefiles.com/packages/lf20_ik4jyixs.json',width: 110,height: 110),
                  Text('\t\t Community\n\n \t Name  \n\n \t XXXXXXXXXXXXXX',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),

                ],
              ),
            ),


            SizedBox(height: 20),

            Container(
              color: Colors.green,
              width: 420,
              height: 80,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Google Ads Banner',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight. bold,
                    ),
                  ),
                ],
              ),
            ),






          ],
        ),



      ),
    );
  }
}
