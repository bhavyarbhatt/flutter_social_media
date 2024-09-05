import 'package:flutter/material.dart';
import 'package:flutter_social_media/pages/FeedScreen.dart';
import 'package:flutter_social_media/pages/NotificationsSceen.dart';
import 'package:flutter_social_media/pages/ProfileScreen.dart';
import 'package:flutter_social_media/pages/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  static  List<Widget> _screens = <Widget>[
    FeedScreen(),
    SearchScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.black, // Color for the selected label
        unselectedItemColor: Colors.grey, // Color for the unselected label

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color:Colors.black,),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Colors.black,),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,color: Colors.black,),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


