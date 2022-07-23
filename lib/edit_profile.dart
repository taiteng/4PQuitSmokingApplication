import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/loginScreen.dart';
import 'package:quit_smoking/signUpScreen.dart';
import 'package:quit_smoking/surveyQ1.dart';
import 'package:quit_smoking/userInfo.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Edit extends StatelessWidget {
  const Edit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey=GlobalKey<FormState>();
    final userController=TextEditingController();
    final emailController=TextEditingController();
    final passwordController=TextEditingController();


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
        body: Form(
        key: formkey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: GestureDetector(
    child: Stack(
    children: <Widget>[
       Container(
          padding: EdgeInsets.only(left: 16,top: 25,right: 16),
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Center(
              child:Stack(
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
                  Positioned(
                    bottom: 0,
                      right: 0,
                      child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Colors.green,
                    ),
                    child: Icon(Icons.edit,color: Colors.white,),
                  ),),
                ],
              ),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: userController,
                decoration:  InputDecoration(
                  labelText: "Username",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: getUserInfo().getUName(),
                  hintStyle:TextStyle(
                    fontSize: 16,fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                validator: (value){
                  return usernameFieldValidator.validate(value!);
                },
              ),
    SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration:  InputDecoration(
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: getUserInfo().getUEmail(),
                  hintStyle:TextStyle(
                    fontSize: 16,fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                validator: (value){
                  return emailFieldValidator.validate(value!);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration:  InputDecoration(
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: '********',
                  hintStyle:TextStyle(
                    fontSize: 16,fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                validator: (value){
                  return passwordFieldValidator.validate(value!);
                },
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child:RaisedButton(
                  elevation: 5,
                  onPressed: (){
                    if(!formkey.currentState!.validate()){
                      return;
                    }
                    FirebaseAuth.instance.currentUser!.updateEmail(emailController.text);
                    FirebaseAuth.instance.currentUser!.updatePassword(passwordController.text);
                    FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).set({
                      'username':userController.text,
                      'email':emailController,

                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Login',)));

                  },
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  color: Colors.white,
                  child: Text(
                    'Update',
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
        ),
    ],
    ),
    ),
        ),

      ),
    );
  }
}
