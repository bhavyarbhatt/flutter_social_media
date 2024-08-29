import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebMobileFrame(child: DemoApp()),
    );
  }
}

class WebMobileFrame extends StatelessWidget {
  final Widget child;

  const WebMobileFrame({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 375, // iPhone 8 width
          height: 667, // iPhone 8 height
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey.shade800, width: 10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: child,
          ),
        ),
      ),
    );
  }
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Demo App'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}