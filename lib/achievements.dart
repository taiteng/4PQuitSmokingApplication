import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class Achievements extends StatelessWidget {
  const Achievements({Key? key}) : super(key: key);

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
            //onPressed: () => Navigator.of(context).pop(),
            onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Tween'))),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue,
                        Colors.blue,
                        Colors.blueAccent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Achievement", style:TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.0),),
                            //Text("Total Achievements Earned", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                            //Text("Global", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue,
                        Colors.blue.shade100,
                        Colors.blueAccent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Colors.white,
                      ),
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        children: [
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: false),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: false),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: false),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: false),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                          AchievementList(img: 'assets/images/nft1.jpg', msg: 'What', isOwned: true),
                        ],
                      ),
                    ),
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

class AchievementList extends StatelessWidget{

  final String img;
  final String msg;
  final bool isOwned;

  const AchievementList({Key? key, required this.img, required this.msg, required this.isOwned}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 3,
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(img, height: 100, width: 100, fit: BoxFit.cover,),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Text(msg, style: TextStyle(color: Colors.black54,),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}