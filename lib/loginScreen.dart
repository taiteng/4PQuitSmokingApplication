
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quit_smoking/admin_main.dart';
import 'package:quit_smoking/main.dart';
import 'package:quit_smoking/signUpScreen.dart';

class emailFieldValidator{
  static String? validate(String value){
    if(value.isEmpty)
    return 'Email must be filled';
    else if(!value.isEmpty && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)){
      return "Enter correct email";
    }else{
      return null;
    }
  }
}

class passwordFieldValidator{
  static String? validate(String value){
    if(value.isEmpty)
      return 'Password must be filled';
    if(value != null && value.length<8){
      return 'Enter min. 8 characters';
    }else{
      return null;
    }
  }
}

class loginScreen extends StatefulWidget{

  @override
  _LoginScreenState createState()=>_LoginScreenState();

}



class _LoginScreenState extends State<loginScreen>{

  final GlobalKey<FormState> formkey=GlobalKey<FormState>();
  var isAdmin;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes: ['email']);
  bool isRememberMe=false;
  bool loading=false;
  Widget buildEmail(){
    return Column(
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.black
            ),
            decoration: InputDecoration(
                border:InputBorder.none,
                contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff5ac18e)
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                    color: Colors.black38
                )
            ),
          ),
        )
      ],
    );
  }

  Widget buildPassword(){
    return Column(
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
          child: TextField(
            obscureText: true,
            style: TextStyle(
                color: Colors.black
            ),
            decoration: InputDecoration(
                border:InputBorder.none,
                contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xff5ac18e)
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                    color: Colors.black38
                )
            ),
          ),
        )
      ],
    );
  }

  Widget buildForgotPass(){
    return Container(
      alignment: Alignment.bottomCenter,
      child:FlatButton(
        onPressed: ()=>print("Forgot Password pressed"),
        padding: EdgeInsets.only(right: 0),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget buildRemember(){
    return Container(
      alignment: Alignment.bottomCenter,
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value){
                setState((){
                  isRememberMe=value!;
                }

                );
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Login',)))
        ,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Login',
          style: TextStyle(
            color: Color(0xff5ac18e),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget buildSignUp(){
    return GestureDetector(
      onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>signUpScreen())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500
              )
            ),
            TextSpan(
              text: 'Sign up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            )
          ]
        ),
      ),
    );
  }

  Widget buildFacebook(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: ()=>_loginWithFacebook()
        ,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Login with Facebook',
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget buildGoogle(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: ()=>_loginWithGoogle()
        ,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        child: Text(
          'Login with Google',
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  void _loginWithGoogle() async{
    setState((){loading = true;});
    try {
      final newuser = await _googleSignIn.signIn();
      final googleAuth = await newuser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );
      
      await FirebaseAuth.instance.signInWithCredential(credential);
      if(await FacebookAuth.instance.accessToken == null){
        await FirebaseFirestore.instance.collection('users').add({
          'email':FirebaseAuth.instance.currentUser?.email,
          'name':FirebaseAuth.instance.currentUser?.displayName,

        });}
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> MyHomePage(title: 'Login',) ), (route) => false);

    }on Exception catch(e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('Log in with Google failed'),
        content: Text(e.toString()),
        actions: [TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Ok'))],

      ));
    }

  }



  void _loginWithFacebook() async{
    setState((){loading = true;});
    try{
      final facebookLoginResult= await FacebookAuth.instance.login();
      final userData= await FacebookAuth.instance.getUserData();
      final facebookAuthCredential= FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      if(await FacebookAuth.instance.accessToken == null){
      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'name': userData['name']

       });}
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> MyHomePage(title: 'Login',) ), (route) => false);

    } on Exception catch(e){
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('Log in with Facebook failed'),
        content: Text('Login failed!'),
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
                      Text('Sign In',
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
                                return emailFieldValidator.validate(value!);
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
                                return passwordFieldValidator.validate(value!);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      buildRemember(),
                      buildForgotPass(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () {
                            if(!formkey.currentState!.validate()){
                              return;
                            }
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => MyHomePage(title: 'Login',)));

                          },
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          color: Colors.white,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xff5ac18e),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      buildSignUp(),
                      buildFacebook(),
                      buildGoogle(),
                    ],
                  ),
                )

              )
            ],
          ),
        ),
      ),
    );
  }
}