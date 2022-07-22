import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'userInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Premium extends StatelessWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: ProPage(),
    );
  }
}

class ProPage extends StatefulWidget {
  const ProPage({Key? key}) : super(key: key);

  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<ProPage> {
  Future<void> ToPro() async {
    FirebaseFirestore.instance.collection('user').doc(getUserInfo().getUID().toString()).update({'isPro': true});

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully became a PRO user.')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.shade100,
            Colors.redAccent,
            Colors.red,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            //onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage(title: 'Tween'))),
            onPressed: ()=>Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue,
                        Colors.blue,
                        Colors.blueAccent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Premium", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0),),
                            //Text("Total Achievements Earned", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                            //Text("Global", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue,
                        Colors.blue.shade100,
                        Colors.blueAccent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Colors.white,
                      ),
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 2,
                        children: [
                          Card(
                            elevation: 3.0,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Benefits of being a PRO user", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,),),
                                Text("RM 20", style: TextStyle(color: Colors.black54,),),
                                Text("No Ads", style: TextStyle(color: Colors.black54,),),
                                Text("Unlock more achievements and the ability to create new achievements", style: TextStyle(color: Colors.black54,),),
                                IconButton(
                                    onPressed: () => ToPro(),
                                    icon: Icon(Icons.add_shopping_cart),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
