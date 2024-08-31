import 'package:flutter/material.dart';

import '../common/Widgets/app_bar.dart';

class MobileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: "Home Screen"),
          Expanded(
            child: Center(
              child: Text('Your app content goes here'),
            ),
          ),
        ],
      ),
    );
  }
}