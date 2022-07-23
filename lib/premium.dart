import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'userInfo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async{
  runApp(const Premium());
}

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

  FToast fToast = FToast();

  _userPRO() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("You have become a PRO user"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      //gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 2),
    );
  }

  Future<void> ToPro() async {
    _userPRO();

    await FirebaseFirestore.instance.collection('user').doc(getUserInfo().getUID().toString()).update({'isPro': "true"});
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Premium'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            //onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage(title: 'Tween'))),
            onPressed: ()=>Navigator.pop(context),
          ),
        ),
        body: Card(
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
              FloatingActionButton(
                onPressed: () => ToPro(),
                child: Icon(Icons.add_shopping_cart),
                key: const ValueKey("pro_btn"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
