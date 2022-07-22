import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quit_smoking/authenticationService.dart';
import 'package:quit_smoking/loginScreen.dart';
import 'package:quit_smoking/main.dart';
import 'surveyQ1.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';



class signUpScreen extends StatefulWidget{

  @override
  _signUpScreenState createState()=>_signUpScreenState();

}

class _signUpScreenState extends State<signUpScreen>{
  final GlobalKey<FormState> formkey=GlobalKey<FormState>();
  bool loading=false;
  late String _email, _password;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final repasswordController=TextEditingController();
  final usernameController=TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    repasswordController.dispose();
    super.dispose();

  }
  // Widget buildUsername(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Username',
  //         style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold
  //         ),
  //
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow:[
  //               BoxShadow(
  //                   color: Colors.black26,
  //                   blurRadius: 6,
  //                   offset: Offset(0,2)
  //               )
  //             ]
  //         ),
  //         height: 60,
  //         child: TextField(
  //           keyboardType: TextInputType.emailAddress,
  //           controller: usernameController,
  //           style: TextStyle(
  //               color: Colors.black
  //           ),
  //           decoration: InputDecoration(
  //               border:InputBorder.none,
  //               contentPadding: EdgeInsets.only(top:14),
  //               prefixIcon: Icon(
  //                   Icons.people,
  //                   color: Color(0xff5ac18e)
  //               ),
  //               hintText: 'Username',
  //               hintStyle: TextStyle(
  //                   color: Colors.black38
  //               )
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget buildEmail(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Email',
  //         style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold
  //         ),
  //
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow:[
  //               BoxShadow(
  //                   color: Colors.black26,
  //                   blurRadius: 6,
  //                   offset: Offset(0,2)
  //               )
  //             ]
  //         ),
  //         height: 60,
  //         child: TextField(
  //           controller: emailController,
  //           keyboardType: TextInputType.emailAddress,
  //           style: TextStyle(
  //               color: Colors.black
  //           ),
  //           decoration: InputDecoration(
  //               border:InputBorder.none,
  //               contentPadding: EdgeInsets.only(top:14),
  //               prefixIcon: Icon(
  //                   Icons.email,
  //                   color: Color(0xff5ac18e)
  //               ),
  //               hintText: 'Email',
  //               hintStyle: TextStyle(
  //                   color: Colors.black38
  //               )
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget buildPassword(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Password',
  //         style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold
  //         ),
  //
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow:[
  //               BoxShadow(
  //                   color: Colors.black26,
  //                   blurRadius: 6,
  //                   offset: Offset(0,2)
  //               )
  //             ]
  //         ),
  //         height: 60,
  //         child: TextField(
  //           obscureText: true,
  //           controller: passwordController,
  //           style: TextStyle(
  //               color: Colors.black
  //           ),
  //           decoration: InputDecoration(
  //               border:InputBorder.none,
  //               contentPadding: EdgeInsets.only(top:14),
  //               prefixIcon: Icon(
  //                   Icons.lock,
  //                   color: Color(0xff5ac18e)
  //               ),
  //               hintText: 'Password',
  //               hintStyle: TextStyle(
  //                   color: Colors.black38
  //               )
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget buildReconfirmPassword(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Reenter Password',
  //         style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold
  //         ),
  //
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow:[
  //               BoxShadow(
  //                   color: Colors.black26,
  //                   blurRadius: 6,
  //                   offset: Offset(0,2)
  //               )
  //             ]
  //         ),
  //         height: 60,
  //         child: TextField(
  //           obscureText: true,
  //           controller: repasswordController,
  //           style: TextStyle(
  //               color: Colors.black
  //           ),
  //           decoration: InputDecoration(
  //               border:InputBorder.none,
  //               contentPadding: EdgeInsets.only(top:14),
  //               prefixIcon: Icon(
  //                   Icons.lock,
  //                   color: Color(0xff5ac18e)
  //               ),
  //               hintText: 'Reenter Password',
  //               hintStyle: TextStyle(
  //                   color: Colors.black38
  //               )
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget buildSignUpBtn(){
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 25),
  //     width: double.infinity,
  //     child: RaisedButton(
  //       elevation: 5,
  //       onPressed: () {
  //
  //
  //         Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (_) => surveyQ1()));
  //       },
  //       padding: EdgeInsets.all(15),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15)
  //       ),
  //       color: Colors.white,
  //       child: Text(
  //         'Sign Up',
  //         style: TextStyle(
  //             color: Color(0xff5ac18e),
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget buildFacebook(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: ()=>_signUpWithFacebook()
        ,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Sign Up with Facebook',
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
  void _signUpWithFacebook() async{
    setState((){loading = true;});
    try{
      final facebookLoginResult= await FacebookAuth.instance.login();
      final userData= await FacebookAuth.instance.getUserData();
      final facebookAuthCredential= FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await Firebase.initializeApp();
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      await FirebaseFirestore.instance.collection('user').add({
        'email':userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],

      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> MyHomePage(title: 'Login',) ), (route) => false);

    } on Exception catch(e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('Log in with Facebook failed'),
        content: Text('Login failed!'+e.toString()),
        actions: [TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Ok'))],

      ));
    }finally{
      setState((){loading = false;});
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 120
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 50),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Username',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:[
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2)
                                  )
                                ]
                            ),
                            height: 60,
                            child: TextFormField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.people),
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value){
                                if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                                  return "Enter correct name";
                                }else{
                                  return null;
                                }
                              },
                            ),
                          )
                        ],
                      ),

                        SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:[
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2)
                                  )
                                ]
                            ),
                            height: 60,
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value){
                                if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value!)){
                                  return "Enter correct email";
                                }else{
                                  return null;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                        SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:[
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0,2)
                                  )
                                ]
                            ),
                            height: 60,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value){
                                if(value != null && value.length<8){
                                  return 'Enter min. 8 characters';
                                }else{
                                  return null;
                                }
                              },
                            ),
                          )
                        ],
                      ),
                        SizedBox(height: 20),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () async {
                            if(!formkey.currentState!.validate()){
                              return;
                            }
                            FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

                            await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.uid).set({

                              'email':emailController.text,
                              'isAdmin':'false',
                              'isPro':'false',
                              'password':passwordController.text,
                              'username':usernameController.text

                            });

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => surveyQ1()));
                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Color(0xff5ac18e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

                        buildFacebook()
                      ],
                    ),
                  )

              )
            ],
          ),
        ),
      )
    );
  }
}


