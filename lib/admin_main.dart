import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin_achievements.dart';
import 'admin_notification.dart';
import 'admin_protips.dart';

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
      home: adminMain(),
    );
  }
}

class adminMain extends StatefulWidget {
  @override
  State<adminMain> createState() => adminMainState();
}

class adminMainState extends State<adminMain>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tween - Admin Panel"),
        backgroundColor: Colors.red[600],
        automaticallyImplyLeading: false,
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[

            //First Row for the containers as the
            //achievement and notification
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[

                InkWell(



                  //First row Container as achievement
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                      border: Border.all(
                        color:Colors.white,
                        width: 0.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 150,
                    height: 180,


                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: <Widget>[
                        Container(
                          child: IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminA()));
                          },
                            icon: Icon(Icons.add_task_outlined),
                            color: Colors.white,
                            iconSize: 40,
                            alignment: Alignment.centerRight,
                          ),

                        ),

                        Text("Achievements",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                  ),
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminA()));
                    }

                ),


                InkWell(
                  //First row container as notifications
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                      border: Border.all(
                        color:Colors.white,
                        width: 0.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 150,
                    height: 180,

                    //First Row of the Container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: <Widget>[
                        Container(
                          child: IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminMain()));
                          },
                            icon: Icon(Icons.notification_add_outlined),
                            color: Colors.white,
                            iconSize: 40,
                            alignment: Alignment.centerRight,
                          ),

                        ),

                        Text("Notifications",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminMain()));
                  },
                ),
              ],
            ),

            //Second Row for the containers as the
            // tips and advertisement
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[

                InkWell(
                  child: //First row Container as achievement
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          border: Border.all(
                            color:Colors.white,
                            width: 0.1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 150,
                        height: 180,


                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          children: <Widget>[
                            Container(
                              child: IconButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminP()));
                              },
                                icon: Icon(Icons.privacy_tip_outlined),
                                color: Colors.white,
                                iconSize: 40,
                                alignment: Alignment.centerRight,
                              ),

                            ),

                            Text("Tips",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                          ],
                        ),
                      ),

                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminP()));
                  }

                ),


                //First row container as notifications
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    border: Border.all(
                      color:Colors.white,
                      width: 0.1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 150,
                  height: 180,

                  //First Row of the Container
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[
                      Container(
                        child: IconButton(onPressed: (){
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => endSurvey()));
                        },
                          icon: Icon(Icons.newspaper),
                          color: Colors.white,
                          iconSize: 40,
                          alignment: Alignment.centerRight,
                        ),
                      ),

                      Text("Advertisements",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}