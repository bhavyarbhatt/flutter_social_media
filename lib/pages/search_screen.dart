import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/.env';
import 'package:flutter_social_media/common/Widgets/drawer.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  List<ImageResult> _results = [];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Fast animation
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation
    Future.delayed(Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _searchImages(String query) async {
    if (query.isEmpty) return;

    final response = await http.get(
      Uri.parse('https://api.unsplash.com/search/photos?query=$query&client_id=${API.unsplashApiKey}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _results = (data['results'] as List)
            .map((item) => ImageResult.fromJson(item))
            .toList();
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  void _logout() {
    // Implement your logout logic here
    Navigator.pushReplacementNamed(context, '/login'); // Example navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Images'),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchImages(_searchController.text);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: _results.isEmpty
                      ? _buildEmptyState()
                      : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      return Image.network(_results[index].urls.small);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: CustomDrawer(onLogout: _logout), // Use the custom drawer here
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching for anything!',
            style: TextStyle(fontSize: 16, color: Colors.grey[50]),
          ),
          SizedBox(height: 16),
          Text(
            'Suggestions:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: [
              _suggestionChip('Cities'),
              _suggestionChip('Technology'),
              _suggestionChip('Animals'),

            ],
          ),
        ],
      ),
    );
  }

  Widget _suggestionChip(String suggestion) {
    return ActionChip(
      label: Text(suggestion),
      onPressed: () {
        _searchController.text = suggestion; // Set the search text
        _searchImages(suggestion); // Trigger search
      },
      backgroundColor: Colors.deepPurple.shade100,
    );
  }
}

class ImageResult {
  final String id;
  final String description;
  final Urls urls;

  ImageResult({required this.id, required this.description, required this.urls});

  factory ImageResult.fromJson(Map<String, dynamic> json) {
    return ImageResult(
      id: json['id'],
      description: json['description'] ?? 'No description',
      urls: Urls.fromJson(json['urls']),
    );
  }
}

class Urls {
  final String small;

  Urls({required this.small});

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      small: json['small'],
    );
  }
}