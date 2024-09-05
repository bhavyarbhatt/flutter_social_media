import 'package:flutter/material.dart';
import 'package:flutter_social_media/common/Widgets/drawer.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Sample data for posts
  List<Post> posts = List.generate(
    10,
        (index) => Post(
      title: 'Post Title $index',
      description: 'This is a sample post description for post number $index. It can be longer and wrap to multiple lines.',
      imageUrl: 'https://picsum.photos/id/${index + 10}/400/200', // Placeholder images
    ),
  );

  void _addPost(Post post) {
    setState(() {
      posts.insert(0, post); // Add new post to the top of the list
    });
  }

  @override
  Widget build(BuildContext context) {

    void _logout() {
      // Implement your logout logic here
      Navigator.pushReplacementNamed(context, '/login'); // Example navigation
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreatePostScreen(onPostCreated: _addPost),
                ),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(onLogout: _logout), // Use the custom drawer here

      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            child: Image.network(
              widget.post.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.post.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    Text('123'), // Placeholder for likes count
                    Icon(Icons.comment, color: Colors.grey),
                    Text('45'), // Placeholder for comments count
                    Icon(Icons.share, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreatePostScreen extends StatefulWidget {
  final Function(Post) onPostCreated;

  const CreatePostScreen({Key? key, required this.onPostCreated}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String imageUrl = 'https://picsum.photos/400/200'; // Placeholder image URL

  void _createPost() {
    final post = Post(
      title: titleController.text,
      description: descriptionController.text,
      imageUrl: imageUrl,
    );

    widget.onPostCreated(post); // Pass the new post back to the feed
    Navigator.of(context).pop(); // Close the create post screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            // Placeholder for image upload
            Image.network(imageUrl, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPost,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String title;
  final String description;
  final String imageUrl;

  Post({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}