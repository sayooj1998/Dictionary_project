import 'package:flutter/material.dart';

class drawerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
       padding: EdgeInsets.all(0),

        children: [
          DrawerHeader(child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text('English <-> മലയാളം  Dictionary',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),),
          ),
          decoration: BoxDecoration(
            color: Colors.blue
          ),),
          ListTile(
            leading: const Icon(Icons.delete),
            title: Text('Delete History'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.keyboard),
            title: Text('Go to Google Indic Keyboard'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: Text('Rate Us'),
            onTap: (){},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text('About Us'),
            onTap: (){},
          )


        ],
      ),
    );
  }
}
