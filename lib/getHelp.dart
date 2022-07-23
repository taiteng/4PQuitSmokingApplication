import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/loginScreen.dart';
import 'package:quit_smoking/surveyQ1.dart';
import 'package:quit_smoking/userInfo.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class getHelp extends StatelessWidget {
  const getHelp({Key? key}) : super(key: key);

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
            //onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Tween'))),
            onPressed: ()=>Navigator.pop(context),
          ),
        ),
        body: Container(

          child: Stack(
            children:  <Widget>[

              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFE53935),
                          Color(0xFFE53935),
                          Color(0xFFE53935),
                          Color(0xFFE53935),
                        ]
                    )
                ),
                child:SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 200,
                            padding: EdgeInsets.only(left: 16,top: 25,right: 16),

                            decoration: new BoxDecoration(
                              image: new DecorationImage(image: new AssetImage('assets/images/klinik.jpg')),
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'clinic:      Klinik Bersatu',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'contact:  04-828 8625',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'location: Ground Floor, 607-H, Jln Balik Pulau, Pekan Ayer Itam, 11500 Ayer Itam, Pulau Pinang',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 200,
                            padding: EdgeInsets.only(left: 16,top: 25,right: 16),

                            decoration: new BoxDecoration(
                              image: new DecorationImage(image: new AssetImage('assets/images/The pearl.jpg')),
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'clinic:      KLINIK PERUBATAN THE PEARL',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'contact:  04-262 7295',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'location: 99, King Street, George Town, 10200 George Town, Pulau Pinang',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 30),
                          Card(
                            child: Column(
                              children: [
                                Text(
                                  'Contact',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Penang Adventist Hospital',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  'Breathe Free Support Group',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '+604 222 7571',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                    ),

                ),
              ),



],
          ),
        ),


      ),
    );
  }
}
