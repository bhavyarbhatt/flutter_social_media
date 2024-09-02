import 'package:get/get.dart';

class Post {
  final String userId;
  final String profilePic;
  final String fullName;
  final String username;
  final String joinedDate;
  final String bio;
  final int followersCount;
  RxBool isLiked;

  Post({
    required this.userId,
    required this.profilePic,
    required this.fullName,
    required this.username,
    required this.joinedDate,
    required this.bio,
    required this.followersCount,
    bool isLiked = false,
  }) : isLiked = RxBool(isLiked);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'].toString(), // Convert to String
      profilePic: json['profilePic'] ?? '',
      fullName: json['fullName'] ?? '',
      username: json['username'] ?? '',
      joinedDate: json['joinedDate'] ?? '',
      bio: json['bio'] ?? '',
      followersCount: json['followersCount'] is int
          ? json['followersCount'] // Keep as int if already int
          : int.tryParse(json['followersCount'].toString()) ?? 0, // Convert to int or default to 0
      isLiked: json['isLiked'] ?? false,
    );
  }
}
