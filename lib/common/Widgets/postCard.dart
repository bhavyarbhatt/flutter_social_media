import 'package:flutter/material.dart';
import 'package:flutter_social_media/common/Widgets/circleAvaster.dart';
import 'package:flutter_social_media/controller/post_controller.dart';
import 'package:get/get.dart';
import '../../models/post_model.dart';

class FeedPage extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshPosts,
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          if (controller.posts.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          return RefreshIndicator(
            onRefresh: controller.refreshPosts,
            child: ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: controller.posts[index],
                );
              },
            ),
          );
        }
      }),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;


  // List of unique person images
  final Map<String, String>  userImages = {
    'user1': 'https://images.unsplash.com/photo-1506801127838-8c8c5f1d4c4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
    'user2': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
    'user3': 'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
    'user4': 'https://images.unsplash.com/photo-1529655683824-7d5b2b0f4b9c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
    'user5': 'https://images.unsplash.com/photo-1501594907353-1a4c5b7d5b9b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
   'user6' :'https://images.unsplash.com/photo-1531498967926-7e4f1f6c8c5b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
   'user7' :'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
   'user8' :'https://images.unsplash.com/photo-1518605738672-3e1c1f1b1e3d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
   'user9' :'https://images.unsplash.com/photo-1506801127838-8c8c5f1d4c4b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
    'user10':'https://images.unsplash.com/photo-1517841905240-472988babdf9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&q=80&w=200',
  };


  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    // Get the image URL based on the username
    String imageUrl = userImages[post.username] ?? ''; // Use a default image if not found

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(imageUrl),
          _buildContent(imageUrl), // Pass the single image URL to _buildContent
        ],
      ),
    );
  }

  Widget _buildHeader(String imageUrl) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatarWithFallback(
            imageUrl: imageUrl, // Use the image URL associated with the username
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '@${post.username}',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                Text(
                  'Joined ${post.joinedDate}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(String imageUrl) { // Accept imageUrl as a parameter
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display a single image for the post
          Container(
            height: 200, // Set a fixed height for the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl, // Use the same image for the post
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Container(
                    color: Colors.grey, // Placeholder color
                    child: Icon(Icons.error, color: Colors.white), // Fallback icon
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            post.bio,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

}

class CircleAvatarWithFallback extends StatelessWidget {
  final String imageUrl;

  CircleAvatarWithFallback({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey,
      backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
      child: imageUrl.isEmpty ? Icon(Icons.person, color: Colors.white) : null,
    );
  }
}