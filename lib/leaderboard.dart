import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            // onPressed: () => Navigator.of(context).pop(),
            onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(title: 'Tween'))),
          ),
          //actions: [Icon(Icons.grid_view, color: Colors.white,),],
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
                        Colors.yellow.shade600,
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xff2C3144),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Leaderboard", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                            //Text("Total Achievements Earned", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                            //Text("Global", style:TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      WinnerContainer(url: 'assets/images/nft1.jpg', rank: '2', winnerName: 'Zhi Cheng', color: Colors.green, winnerPosition: '2', isFirst: false, height: 120),
                      WinnerContainer(url: 'assets/images/nft1.jpg', rank: '1', winnerName: 'E Soon', color: Colors.orange, winnerPosition: '1', isFirst: true, height: 140),
                      WinnerContainer(url: 'assets/images/nft1.jpg', rank: '3', winnerName: 'David', color: Colors.blue, winnerPosition: '3', isFirst: false, height: 120),
                    ],
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
                        Colors.yellow.shade600,
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        color: Colors.black,
                      ),
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 3.5,
                        children: [
                          ContestantList(rank: '1', name: 'E Soon', url: 'assets/images/nft1.jpg',),
                          ContestantList(rank: '2', name: 'Zhi Cheng', url: 'assets/images/nft1.jpg',),
                          ContestantList(rank: '3', name: 'David', url: 'assets/images/nft1.jpg',),
                          ContestantList(rank: '4', name: 'Taiteng', url: 'assets/images/nft1.jpg',),
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


class WinnerContainer extends StatelessWidget{
  final bool isFirst;
  final Color color;
  final String url;
  final String winnerPosition;
  final String winnerName;
  final String rank;
  final double height;

  const WinnerContainer({Key? key, required this.isFirst, required this.color, required this.winnerPosition, required this.winnerName, required this.rank, required this.height, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children:[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.yellow.shade600,
                    Colors.orange,
                    Colors.red,
                  ],),
                  border: Border.all(
                    color: Colors.amber,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Center(
                    child: Container(
                      height: height,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0xff2C3144),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0),),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Stack(
              children:[
                if(isFirst)
                Image.asset('assets/images/crown-removebg-preview.png', height: 70.0, width:100.0),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 12.5),
                  child: ClipOval(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      //height: 60.0,
                      //width: 60.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow.shade600,
                            Colors.orange,
                            Colors.red,
                          ],
                        ),
                        //shape: BoxShape.circle,
                        border: Border.all(color: Colors.amber),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(url, height: 70, width: 70, fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 115.0, left: 40.0),
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: Center(
                      child: Text(rank, style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150.0,
            child: Container(
              width: 100.0,
              child: Center(
                child: Column(
                  children: [
                    Text(winnerName, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold,),),
                    Text(rank, style: TextStyle(color: color, fontSize: 16.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContestantList extends StatelessWidget{
  final String url;
  final String name;
  final String rank;

  const ContestantList({Key? key, required this.url, required this.name, required this.rank}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0, top: 10.0,),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade100,
              Colors.red,
              Colors.yellow.shade300,
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff2C3144),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(url, height: 60.0, width: 60.0, fit: BoxFit.fill,),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(color: Colors.white,)),
                      Text('@${name}', style: TextStyle(color: Colors.white54, fontSize: 12.0,)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(rank, style: TextStyle(color: Colors.white,),),
                      Icon(Icons.favorite, color: Colors.red,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}