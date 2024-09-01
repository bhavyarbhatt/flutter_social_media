import 'package:flutter/material.dart';
import 'package:flutter_social_media/common/Widgets/app_bar.dart';

import '../common/Widgets/postCard.dart';

class MobileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: UniqueSocialApp()
            ),

        ],
      ),
    );
  }
}


class UniqueSocialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Color(0xFF6200EE),
      //   hintColor: Color(0xFF03DAC5),
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: SocialHomePage(),
    );
  }
}

class SocialHomePage extends StatefulWidget {
  @override
  _SocialHomePageState createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "SocialWave"),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  FeedPage(),
                  Center(child: Text('Discover')),
                  Center(child: Text('Create')),
                  Center(child: Text('Activity')),
                  Center(child: Text('Profile')),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}



// Insta Story like screen
// class TrendingTopics extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(15),
//                     gradient: LinearGradient(
//                       colors: [Theme.of(context).primaryColor, Color(0xFF03DAC5) ],
//                     ),
//                   ),
//                   child: Center(
//                     child: Icon(Icons.trending_up, color: Colors.white, size: 30),
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text('#Trend${index + 1}', style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(icon: Icons.home, isSelected: selectedIndex == 0, onTap: () => onItemTapped(0)),
          NavBarItem(icon: Icons.explore, isSelected: selectedIndex == 1, onTap: () => onItemTapped(1)),
  // Image Add Button
          // NavBarItem(icon: Icons.add_box, isSelected: selectedIndex == 2, onTap: () => onItemTapped(2)),
  // Live Button
          // NavBarItem(icon: Icons.favorite, isSelected: selectedIndex == 3, onTap: () => onItemTapped(3)),
          NavBarItem(icon: Icons.person, isSelected: selectedIndex == 4, onTap: () => onItemTapped(4)),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  NavBarItem({required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              size: 28,
            ),
            SizedBox(height: 4),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}