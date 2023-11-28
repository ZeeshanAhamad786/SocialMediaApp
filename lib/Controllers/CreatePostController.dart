// Import necessary packages and classes
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../Models/CreatePostModel.dart';


import '../Models/postModel.dart';
import 'GetuserdataDataController.dart';

// Define the CreatePostController class
class CreatePostController extends GetxController {


  // Controller for handling the post description input
  TextEditingController postDescriptionController = TextEditingController();

  // Controller for getting user data
  GetUserDataController getUserDataController = Get.put(GetUserDataController());

  // Fields related to authentication
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Firestore collection reference for posts
  final CollectionReference userData = FirebaseFirestore.instance.collection('Posts');

  // Method for handling the creation of a new post
  createPostHandler({
    required String postId,
    required String userId,
    required String username,
    required File userPostImage, // Updated the parameter type to singular
    required String userProfileImage,
    required String description,
    required String timestamp,
  }) async {
    // Check if the post description is not empty
    if (postDescriptionController.text.isNotEmpty) {
      try {
        // Get the current date and time
        DateTime currentPhoneDate = DateTime.now();
        Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

        // Get the current user's ID
        String user = FirebaseAuth.instance.currentUser!.uid;

        // Check if the user is authenticated
        if (user.isNotEmpty) {
          // Upload post image
          final postImageRef = firebase_storage.FirebaseStorage.instance.ref('post_images/$postId');
          await postImageRef.putFile(userPostImage);
          final postImageUrl = await postImageRef.getDownloadURL();

          String profileImageUrl = getUserDataController.getUserDataRxModel.value!.profileimage;

          // Add the post to Firestore
          addUser(
            userID: user,
            postId: postId,
            userId: userId,
            username: username,
            userPostImage: postImageUrl, // Updated the parameter name to singular
            userProfileImage: profileImageUrl,
            description: description,
            timestamp: myTimeStamp.toDate().toString(),
          );
        }
      } catch (e) {
        Get.snackbar('Error', (e.toString()));
      }
    } else {
      // Show a snackbar if the post description is empty
      Get.snackbar('Required', 'All fields are Required');
    }
  }

  // Method for adding a post to Firestore
  Future<void> addUser({
    required String userID,
    required String postId,
    required String userId,
    required String username,
    required String userPostImage, // Updated the parameter type to singular
    required String userProfileImage,
    required String description,
    required String timestamp,
  }) async {
    // Create a new post model
    final CreatePostModel post = CreatePostModel(
      postId: postId,
      userId: userId,
      likes: RxList<LikeModel>(),
      comments: RxList<CommentModel>(),
      username: username,userPostImage: userPostImage
     , // Updated the parameter name to singular
      userProfileImage: userProfileImage,
      description: description,
      timestamp: DateTime.parse(timestamp),
    );

    try {
      // Add the post to Firestore
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(userID)
          .collection('userPosts')
          .doc(postId)
          .set(post.toMap());

      // Show a success snackbar
      getAllPosts();
      Get.snackbar('Success', 'Post created successfully.');


    } catch (e) {
      // Show an error snackbar if the post creation fails
      Get.snackbar('Error', 'Failed to create post: $e');
    }
  }
  // Method to toggle like for a specific post
  void toggleLikeForPost(String postId) {
    final post = postsList.firstWhere(
          (p) => p.postId == postId,
      orElse: () => CreatePostModel(
        postId: '',
        userId: '',
        username: '',
        userPostImage: '',
        userProfileImage: '',
        description: '',
        timestamp: DateTime.now(),
        likes: RxList<LikeModel>(),
        comments: RxList<CommentModel>(),
      ),
    );

    final userUid = FirebaseAuth.instance.currentUser!.uid;

    if (post.likes.any((like) => like.userId == userUid)) {
      // If the user already liked, remove the like
      post.likes.removeWhere((like) => like.userId == userUid);
      removeLikeFromDatabase(post.postId, userUid); // Remove like from Realtime Database
    } else {
      // If the user hasn't liked, add a new like
      post.likes.add(LikeModel(userId: userUid));
      addLikeToDatabase(post.postId, userUid); // Add like to Realtime Database
    }

    // Update the post in Firestore

  }

// Method to add a like to Realtime Database
  void addLikeToDatabase(String postId, String userUid) {
    try {
      final likeReference = FirebaseDatabase.instance.reference().child('likes').child(postId).child(userUid);
      likeReference.set(true);
    } catch (e) {
      print("Error adding like to Realtime Database: $e");
    }
  }

// Method to remove a like from Realtime Database
  void removeLikeFromDatabase(String postId, String userUid) {
    try {
      final likeReference = FirebaseDatabase.instance.reference().child('likes').child(postId).child(userUid);
      likeReference.remove();
    } catch (e) {
      print("Error removing like from Realtime Database: $e");
    }
  }


  // List to store user posts
  RxList<CreatePostModel> postsList = RxList<CreatePostModel>();

  // Method to get all users posts from Firestore
  Future<void> getAllPosts() async {
    try {
      // Listen for real-time updates on the 'userPosts' collection for all users
      FirebaseFirestore.instance
          .collectionGroup('userPosts').orderBy('timestamp',descending: true)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        // Clear the existing posts list
        postsList.clear();

        // Iterate through the retrieved documents and convert them to PostModel
        querySnapshot.docs.forEach((doc) async {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          try {
            // Create a post model
            CreatePostModel post = CreatePostModel.fromMap(data);

            // Fetch likes for the post
            await fetchLikesForPost(post);

            // Add the post to the list
            postsList.add(post);
          } catch (e) {
            print("Error converting document to CreatePostModel: $e");
          }
        });

        // Print the number of posts retrieved (for debugging)
        print("Number of posts retrieved from all users: ${postsList.length}");
      });
    } catch (e) {
      // Handle any errors that may occur during the process
      print("Error fetching posts: $e");
      Get.snackbar('Error', 'Failed to get posts: $e');
    }
  }
  Future<void> fetchLikesForPost(CreatePostModel post) async {
    try {
      // Fetch likes for the post from Realtime Database
      final likeSnapshot = await FirebaseDatabase.instance
          .reference()
          .child('likes')
          .child(post.postId)
          .once();

      final Map<dynamic, dynamic>? likesMap = likeSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      // Check for null and update the likes property of the post
      if (likesMap != null) {
        final List<String> likesList =
        likesMap.entries.where((entry) => entry.value == true).map((entry) => entry.key.toString()).toList();

        post.likes.clear();
        post.likes.addAll(likesList.map((userId) => LikeModel(userId: userId)).toList());
      } else {
        print("Likes map is null");
      }
    } catch (e) {
      print("Error fetching likes for post: $e");
    }
  }









  // Rx variable for the selected post image
  Rx<File?> selectedPostImage = Rx<File?>(null);

  // Method to pick a post image from the gallery
  pickedPostImage() async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedPostImage.value = File(pickedFile.path);
        log(selectedPostImage.value.toString());
      } else {
        // Show a snackbar if no image is selected
        Get.snackbar("No Image", "Please Select Image");
      }
    } catch (e) {
      // Show an error snackbar if an error occurs during image picking
      Get.snackbar("An Error", " ${e.toString()}");
    }
  }


}
