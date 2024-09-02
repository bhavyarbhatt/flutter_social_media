import 'package:flutter_social_media/models/post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';






https://ozgrozer.github.io/100k-faces/0/4/004378.jpg,
https://ozgrozer.github.io/100k-faces/0/6/006875.jpg,
https://ozgrozer.github.io/100k-faces/0/9/009063.jpg,
https://ozgrozer.github.io/100k-faces/0/6/006164.jpg,
https://ozgrozer.github.io/100k-faces/0/7/007474.jpg,
https://ozgrozer.github.io/100k-faces/0/7/007579.jpg,
https://ozgrozer.github.io/100k-faces/0/8/008766.jpg,
https://ozgrozer.github.io/100k-faces/0/6/006339.jpg,
https://ozgrozer.github.io/100k-faces/0/2/002212.jpg,
https://ozgrozer.github.io/100k-faces/0/2/002295.jpg,



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

      // Fetch a list of unique image URLs
      List<String> uniqueImageUrls = await fetchImageUrls(10);
      imageUrls.value = uniqueImageUrls;

    } catch (e) {
      print('Failed to load images: $e');
    }
  }

  // Future<List<String>> fetchUniqueImageUrls(int count) async {
  //   Set<String> uniqueImageUrls = {};
  //
  //   const url = 'https://100k-faces.glitch.me/random-image-url'; // Direct URL
  //
  //
  //
  //   for (int i = 0; i < count; i++) {
  //     try {
  //       // final response = await http.get(Uri.parse(
  //       //     'https://api.allorigins.win/raw?url=${Uri.encodeComponent('https://100k-faces.glitch.me/random-image-url')}'));
  //
  //       final response = await http.get(Uri.parse(url));
  //       print('Response body: ${response.body}');
  //
  //
  //       if (response.statusCode == 200) {
  //         imageUrls.add(response.body);
  //       } else {
  //         print('Error: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       print('Failed to load image URL: $e');
  //     }
  //   }
  //
  //   return imageUrls;
  // }

// try this
  Future<List<String>> fetchImageUrls(int count) async {
    List<String> imageUrls = [];
    const url = 'https://100k-faces.glitch.me/random-image-url'; // Direct URL

    for (int i = 0; i < count; i++) {
      bool success = false;
      int retryCount = 0;

      while (!success && retryCount < 3) {
        try {
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            imageUrls.add(response.body);
            success = true;
          } else {
            print('Error: ${response.statusCode}');
            retryCount++;
          }
        } catch (e) {
          print('Failed to load image URL: $e');
          retryCount++;
        }
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
            Post.fromJson(profile)).toList();

        // Load images after posts are fetched
        loadImages();

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



