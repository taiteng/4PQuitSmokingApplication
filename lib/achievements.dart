import 'dart:async';
import 'package:flutter/material.dart';

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
          //title: Text('Achievements page'),
          //centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: () => Navigator.of(context).pop(),
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

/*
class AchivmentsPage extends StatefulWidget {
  @override
  createState() => _AchivmentsState();
}
class _AchivmentsState extends State<AchivmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: CircleBadge(
            color: Color.fromRGBO(255, 255, 255, 1.0),
            title: "6000",
            subtitle: "SubTitle"),
      ),
    );
  }
}
class CircleBadge extends StatelessWidget {
  final Color color;
  final String title, subtitle;

  CircleBadge({required this.color, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 40.0,
            height: 40.0,
            transform: Matrix4.translationValues(0.0, 102.0, 0.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: this.color,
              gradient: LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.grey.shade100,
                  Colors.blueGrey,
                ],
              ),
            ),
          child: CustomPaint(
            size: Size(40, 40),
            painter: TriangleClipper(),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: this.color,
            border: Border.all(
              color: Color.fromRGBO(255, 255, 255, 1.0),
              width: 3.0,
            ),
          ),
          padding: EdgeInsets.all(6.0),
          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
          height: 80.0,
          width: 120.0,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: this.color,
              border: Border.all(
                color: Color.fromRGBO(255, 255, 255, 1.0),
                width: 3.0,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.title,
                  style: TextStyle(
                    color: (this.color != Color.fromRGBO(255, 255, 255, 1.0))
                        ? Colors.white
                        : Colors.blue[100],
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  this.subtitle,
                  style: TextStyle(
                    color: (this.color != Color.fromRGBO(255, 255, 255, 1.0))
                        ? Colors.black54
                        : Colors.blue[100],
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TriangleClipper extends CustomPainter {
  Paint _paint = Paint();

  TriangleClipper() {
    _paint = Paint()
      ..color = Color.fromRGBO(231, 241, 248, 1.0)
      ..style = PaintingStyle.fill;
  }
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height - 15.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, this._paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

*/