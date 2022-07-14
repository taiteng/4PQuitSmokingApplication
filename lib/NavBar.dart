import 'package:flutter/material.dart';
import 'achievements.dart';
import 'leaderboard.dart';
import 'protips.dart';
import 'chat.dart';
import 'settings.dart';
import 'premium.dart';
import 'demo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: NBPage(),
    );
  }
}

class NBPage extends StatefulWidget {
  const NBPage({Key? key}) : super(key: key);

  @override
  _NBState createState() => _NBState();
}

class _NBState extends State<NBPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.transparent,
        child: ListView(
          // Remove padding
          padding: EdgeInsets.only(right: 100),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Oflutter.com'),
              accountEmail: Text('example@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Achievement'),
              //onTap: () => Achievements(),
              onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Achievements())),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Communinty'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Chats())),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Pro Tips'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Protip())),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Premium'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Premium())),
            ),
            ListTile(
              leading: Icon(Icons.leaderboard),
              title: Text('Leaderboard'),
              //onTap: () => null,
              onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Leaderboard())),
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Setting())),
            ),
            ListTile(
              leading: Icon(Icons.airplanemode_on_rounded),
              title: Text('Demo'),
              onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Demo())),
            ),
          ],
        ),
      ),
    );
  }
}