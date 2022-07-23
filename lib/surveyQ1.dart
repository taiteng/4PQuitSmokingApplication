import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'surveyQ2.dart';
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
      home: const SurveyQ1(),
    );
  }
}

class SurveyQ1 extends StatefulWidget {
  const SurveyQ1({Key? key}) : super(key: key);

  @override
  State<SurveyQ1> createState() => SurveyQ1State();
}

class SurveyQ1State extends State<SurveyQ1> with AutomaticKeepAliveClientMixin<SurveyQ1>{
  final q1controller = TextEditingController();

  Future<void> costPerPack(String q1) async{
    await Firebase.initializeApp();
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid.toString();
    final String? uname = user?.displayName.toString();

    final surveyQuestion = FirebaseFirestore.instance.collection('surveys').doc(uid);

    await surveyQuestion.set({"costPerPack": q1});
    await surveyQuestion.update({"username": uname });
    await surveyQuestion.update({"time": "00:00:00:00"});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Question 1"),
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
                  image: AssetImage("assets/images/surveyQ1.jpg"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.horizontal(),
              ),
            ),

            const SizedBox(height: 50,),

            Row(
              children: <Widget>[
                Container(
                  width: 330,
                ),
                IconButton(onPressed: () async{
                  final q1 = q1controller.text;

                  if(q1 == ""){
                    const snackBar = SnackBar(
                      content: Text('Please make sure you fill in the field'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    costPerPack(q1);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SurveyQ2()));
                  }

                },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),

                child: const Text("Cost of the cigarrates per pack?",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),

            const SizedBox(height:20.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color:Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: q1controller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "e.g.  20"
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}