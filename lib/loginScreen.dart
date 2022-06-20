import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quit_smoking/main.dart';
import 'package:quit_smoking/signUpScreen.dart';

class loginScreen extends StatefulWidget{

  @override
  _LoginScreenState createState()=>_LoginScreenState();

}


class _LoginScreenState extends State<loginScreen>{
  bool isRememberMe=false;
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
        onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage()))
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
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
                      buildEmail(),
                      SizedBox(height: 20),
                      buildPassword(),
                      SizedBox(height: 20),
                      buildRemember(),
                      buildForgotPass(),
                      buildLoginBtn(),
                      buildSignUp()
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