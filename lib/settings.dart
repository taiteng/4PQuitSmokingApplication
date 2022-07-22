import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quit_smoking/edit_profile.dart';
import 'package:quit_smoking/loginScreen.dart';
import 'package:quit_smoking/surveyQ1.dart';
import 'package:quit_smoking/userInfo.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

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
                    Text('Setting',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            boxShadow:[ BoxShadow(
                                spreadRadius: 2, blurRadius: 10,
                                color:Colors.black.withOpacity(0.1),
                                offset: Offset(0,10)
                            )],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:NetworkImage(getUserInfo().getUImg().toString())
                            ),


                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    Text(getUserInfo().getUName().toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 20),
                    Text(getUserInfo().getUEmail().toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child:RaisedButton(
                          elevation: 5,

                          onPressed: (){

                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Edit()));

                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,

                          child: Text(
                            'Edit',
                            style: TextStyle(
                                color: Color(0xff5ac18e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                       child: RaisedButton(
                          elevation: 5,
                          onPressed: (){

                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Edit()));

                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Get Help',
                            style: TextStyle(
                                color: Color(0xff5ac18e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                        child:RaisedButton(
                          elevation: 5,
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>loginScreen()));

                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Color(0xff5ac18e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        ),
                      ],
                    ),

                    ]
                )

                ),
                ),




                  ],

            ),
          ),


      ),
    );
  }
}
