import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CreatePostModel {
  final String postId;
  final String userId;
  final String username;
  final String userPostImage;
  final String userProfileImage;
  final String description;
  final DateTime timestamp;
  RxList<LikeModel> likes = <LikeModel>[].obs;
  final RxList<CommentModel> comments;


  CreatePostModel({
    required this.postId,
    required this.userId,
    required this.username,
    required this.userPostImage,
    required this.userProfileImage,
    required this.description,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  // Convert a Map to a CreatePostModel instance
  // Convert a Map to a CreatePostModel instance
// Convert a Map to a CreatePostModel instance
  factory CreatePostModel.fromMap(Map<String, dynamic> data) {
    try {
      return CreatePostModel(
        postId: data['postId'] ?? '', // Replace 'postId' with the actual key in your data
        userId: data['userId'] ?? '',
        username: data['username'] ?? '',
        userPostImage: data['userPostImage'] ?? '',
        userProfileImage: data['userProfileImage'] ?? '',
        description: data['description'] ?? '',
        timestamp: data['timestamp'] != null ? DateTime.parse(data['timestamp']) : DateTime.now(),
        likes: (data['likes'] as List<dynamic>? ?? []).map((like) => LikeModel.fromMap(like)).toList().obs,
        comments: (data['comments'] as List<dynamic>? ?? []).map((comment) => CommentModel.fromMap(comment)).toList().obs,// Properly convert String to DateTime
      );
    } catch (e) {
      print("Error creating CreatePostModel: $e");
      // You may need to handle this differently based on your class structure
      // For example, you could return a default CreatePostModel or throw an exception
      return CreatePostModel(
        postId: '',
        userId: '',
        username: '',
        userPostImage: '',
        userProfileImage: '',
        description: '',
        timestamp: DateTime.now(),
        likes: RxList<LikeModel>(), // Initialize an empty RxList
        comments: RxList<CommentModel>(), // Initialize an empty RxList
      );
    }
  }




  // Convert a CreatePostModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'username': username,
      'userPostImage': userPostImage,
      'userProfileImage': userProfileImage,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes.map((like) => like.toMap()).toList(),
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}
class LikeModel {
  final String userId;

  LikeModel({required this.userId});

  factory LikeModel.fromMap(Map<String, dynamic> data) {
    return LikeModel(userId: data['userId'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId};
  }
}

class CommentModel {
  final String userId;
  final String text;

  CommentModel({required this.userId, required this.text});

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(userId: data['userId'] ?? '', text: data['text'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'text': text};
  }
}
