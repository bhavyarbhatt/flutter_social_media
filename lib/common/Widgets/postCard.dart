import 'package:flutter/material.dart';
import 'package:flutter_social_media/controller/post_controller.dart';
import 'package:get/get.dart';
import '../../models/post_model.dart';


// ver 1 working without api

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
          return RefreshIndicator(
            onRefresh: controller.refreshPosts,
            child: ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: controller.posts[index],
                  imageUrls: controller.imageUrls, // Pass the imageUrls here
                );
              },
            ),
          );
        }
      }),
    );
  }
}

// old ver-1 working






// class PostCard extends StatefulWidget {
//   final Map<String, dynamic> post;
//
//   PostCard({required this.post});
//
//   @override
//   _PostCardState createState() => _PostCardState();
// }
//
// class _PostCardState extends State<PostCard> {
//   bool isLiked = false;
//
//   void _toggleLike() {
//     setState(() {
//       isLiked = !isLiked;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.white,
//       margin: EdgeInsets.symmetric(horizontal: 16),
//       shape: RoundedRectangleBorder(
//         side: BorderSide(color: Colors.black, width: 1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildHeader(),
//           _buildContent(),
//           _buildImage(),
//           _buildInteractionBar(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 24,
//             backgroundImage: NetworkImage(widget.post['profileImage']),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.post['username'],
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 Text(
//                   widget.post['timeAgo'],
//                   style: TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContent() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Text(
//         widget.post['caption'],
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }
//
//   Widget _buildImage() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.network(
//           widget.post['postImage'],
//           fit: BoxFit.cover,
//           width: double.infinity,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInteractionBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(16),
//           bottomRight: Radius.circular(16),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             GestureDetector(
//               onTap: _toggleLike,
//               child: Icon(
//                 isLiked ? Icons.favorite : Icons.favorite_border,
//                 color: isLiked ? Colors.red : Colors.black,
//                 size: 28,
//               ),
//             ),
//             SizedBox(width: 8),
//             Text(
//               '${widget.post['likes']}',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// ver-2 red color button ui updated


class PostCard extends StatelessWidget {
  final Post post;
  final List<String> imageUrls; // List of image URLs


  PostCard({required this.post, required this.imageUrls});

  final PostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContent(),
          // _buildLikeBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            // backgroundImage: NetworkImage(post.profilePic),
            backgroundImage: NetworkImage(getRandomImageUrl()), // Get random image URL
          ),
          SizedBox(width: 12),
          Column(
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
        ],
      ),
    );


  }

  String getRandomImageUrl() {
    final random = (imageUrls..shuffle()).first; // Get random image URL
    return random;
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        post.bio,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  //   Widget _buildLikeBar() {
  //   return Obx(() => GestureDetector(
  //     onTap: () => controller.toggleLike(post.userId),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: post.isLiked ? Colors.red : Colors.white,
  //         borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(16),
  //           bottomRight: Radius.circular(16),
  //         ),
  //         border: post.isLiked ? null : Border.all(color: Colors.grey),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               Icons.favorite,
  //               color: post.isLiked ? Colors.white : Colors.grey,
  //               size: 24,
  //             ),
  //             SizedBox(width: 8),
  //             Text(
  //               '${post.followersCount} followers',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: post.isLiked ? Colors.white : Colors.black,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ));
  // }
}


// ver-3 api


