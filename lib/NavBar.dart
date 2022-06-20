
import 'package:flutter/material.dart';
import 'achievements.dart';
import 'leaderboard.dart';


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
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Pro Tips'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Premium'),
            onTap: () => null,
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
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
