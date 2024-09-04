import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/pages/login_app.dart';
import 'package:flutter_social_media/pages/register_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveFrame(),
    );
  }
}

class ResponsiveFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double breakpoint = 600;

    return screenSize.width > breakpoint ? WebMobileFrame() : SplashScreen();
  }
}

class WebMobileFrame extends StatefulWidget {
  const WebMobileFrame({Key? key}) : super(key: key);

  @override
  _WebMobileFrameState createState() => _WebMobileFrameState();
}

class _WebMobileFrameState extends State<WebMobileFrame> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  bool _isSplashCompleted = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => _updateTime());
    _startSplashTimer(); // Start splash timer
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  void _startSplashTimer() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isSplashCompleted = true; // Mark splash as completed after 3 seconds
      });
    });
  }

  String _formatTime(BuildContext context) {
    return TimeOfDay.fromDateTime(_currentTime).format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 375, // iPhone X width
          height: 812, // iPhone X height
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey.shade800, width: 10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              children: [
                // Status bar
                Container(
                  height: 44,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          _formatTime(context),
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.signal_cellular_alt_2_bar_outlined,
                                color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Icon(Icons.wifi_2_bar,
                                color: Colors.black, size: 16),
                            SizedBox(width: 4),
                            Icon(Icons.battery_2_bar,
                                color: Colors.black, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Main content - Use a nested Navigator for all navigation
                Expanded(
                  child: Navigator(
                    onGenerateRoute: (settings) {
                      WidgetBuilder builder;
                      switch (settings.name) {
                        case '/':
                          builder = (BuildContext _) => _isSplashCompleted
                              ? LoginScreen()
                              : SplashScreen();
                          break;
                        case '/home':
                          builder = (BuildContext _) => HomeScreen();
                          break;


                        case '/register':
                          builder = (BuildContext _) => RegisterScreen();
                          break;

                        default:
                          throw Exception('Invalid route: ${settings.name}');
                      }
                      return MaterialPageRoute(
                          builder: builder, settings: settings);
                    },
                  ),
                ),
                // Home indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: 135,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2.5),
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

// Splash Screen Widget
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png', // Your primary logo path
            width: 150,
            height: 150,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              // If the logo is not found, display the default logo
              return Icon(
                Icons.flutter_dash, // Flutter logo icon
                size: 150, // Size of the icon
                color: Colors.white, // Color of the icon
              );
            },
          ),
        ));
  }
}

// Home Screen Widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/details');
          },
          child: Text('Go to Details'),
        ),
      ),
    );
  }
}

