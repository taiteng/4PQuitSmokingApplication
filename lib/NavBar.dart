import 'temp.dart';
import 'package:flutter/material.dart';
import 'achievements.dart';
import 'leaderboard.dart';
import 'community.dart';
import 'protips.dart';
import 'demo.dart';
import 'settings.dart';
import 'premium.dart';


class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
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
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Community())),
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
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Settings())),
          ),
          ListTile(
            leading: Icon(Icons.airplanemode_on_rounded),
            title: Text('Demo'),
            onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Chat())),
          ),
        ],
      ),
    );
  }
}
