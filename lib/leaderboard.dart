import 'dart:async';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //title: Text('Achievements page'),
          //centerTitle: true,
          elevation: 0.0,
          leading: Icon(Icons.arrow_back_ios, color: Colors.white,),
          actions: [Icon(Icons.grid_view, color: Colors.white,),],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff2C3144),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Username", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                        Text("Total Achievements Earned", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                        //Text("Global", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                WinnerContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class WinnerContainer extends StatelessWidget{
  const WinnerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Image.asset('assets/images/nft1.jpg', height: 70.0, width: 70.0),
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red)
          ),
        ),
      ],
    );
  }
}