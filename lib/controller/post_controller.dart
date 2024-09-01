import 'package:flutter_social_media/models/post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var imageUrls = <String>[].obs; // Observable list of image URLs


  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }


  void loadImages() async {
    try {
      imageUrls.value = await fetchImageUrls(10); // Fetch 10 different images
    } catch (e) {
      print('Failed to load images: $e');
    }
  }


  Future<List<String>> fetchImageUrls(int count) async {
    List<String> imageUrls = [];
    for (int i = 0; i < count; i++) {
      final response = await http.get(Uri.parse(
          'https://api.allorigins.win/raw?url=${Uri.encodeComponent('https://100k-faces.glitch.me/random-image-url')}'));

      if (response.statusCode == 200) {
        imageUrls.add(response.body); // Add the fetched image URL to the list
      } else {
        throw Exception('Failed to load image URL');
      }
    }
    return imageUrls;
  }


  Future<void> fetchPosts() async {
    isLoading(true);
    errorMessage('');
    try {
      final profilesResponse = await http.get(Uri.parse('https://dummyapi.online/api/social-profiles'));

      if (profilesResponse.statusCode == 200) {
        final profilesData = json.decode(profilesResponse.body) as List;

        posts.value = profilesData.map((profile) =>
            Post.fromJson(profile as Map<String, dynamic>)
        ).toList();
      } else {
        errorMessage('Failed to load data. Please try again.');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      errorMessage('An error occurred. Please check your internet connection and try again.');
    } finally {
      isLoading(false);
    }
  }





  Future<void> refreshPosts() async {
    await fetchPosts();
  }
}