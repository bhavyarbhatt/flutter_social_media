import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function onLogout;

  const CustomDrawer({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              onLogout(); // Call the logout function passed from the parent
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}