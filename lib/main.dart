import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


  final CollectionReference _surveyss =
  FirebaseFirestore.instance.collection('surveys');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: const Text('Tween'),
      ),
      // Using StreamBuilder to display all surveys from Firestore in real-time
      body: StreamBuilder(
        stream: _surveyss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];

                return Card(
                  child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.cyan,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(documentSnapshot['cigarattesPerDay'].toString(), style: TextStyle(fontSize: 60)),
                                    Text("Saved", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                                Container(
                                  height: 80,
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 5,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(documentSnapshot['costPerPack'].toString(), style: TextStyle(fontSize: 60)),
                                    Text("Cost", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 5),

                        Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(documentSnapshot['quantityPerPack'].toString(), style: TextStyle(fontSize: 60)),
                                    Text("Saved", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                                Container(
                                  height: 80,
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 5,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(documentSnapshot['quantityPerPack'].toString(), style: TextStyle(fontSize: 60)),
                                    Text("Achivement", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ),

                        SizedBox(height: 5),

                        Container(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(documentSnapshot['quitSmokingDate'].toString(), style: TextStyle(fontSize: 60)),
                                    Text("quitSmokingDate", style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        ListTile(
                            tileColor: Colors.yellow,
                            title: Text('Achievement'),
                            subtitle: Text('5'),
                            leading: const Icon(Icons.favorite),
                            onTap: () => print("ListTile")
                        ),

                        SizedBox(height: 15),
                        ListTile(
                            tileColor: Colors.orange,
                            title: Text('Pro Tips'),
                            trailing: const Icon(Icons.share),
                            subtitle: Text('blablablablablablbalbalbab'),
                            onTap: () => print("ListTile")
                        ),


                        SizedBox(height: 15),
                        ListTile(
                            tileColor: Colors.purpleAccent,
                            title: Text('Community'),
                            leading: const Icon(Icons.person),
                            subtitle: Text('blablablablablablbalbalbab'),
                            onTap: () => print("ListTile")
                        ),


                        SizedBox(height: 15),
                        ListTile(
                            tileColor: Colors.grey,
                            title: Text('Google Ads'),
                            subtitle: Text('blablablablablablbalbalbab'),
                            onTap: () => print("ListTile")
                        ),
                      ]),
                );



              },
            );


          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
    );
  }




}
