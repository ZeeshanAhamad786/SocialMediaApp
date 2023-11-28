
import 'package:get/get.dart';

// class PostController extends GetxController {
//   final RxInt likes = 0.obs;
//   final RxInt comments = 0.obs;
//
//   void incrementLikes() {
//     likes.value++;
//   }
//
//   void incrementComments() {
//     comments.value++;
//   }
// }

import 'package:get/get.dart';

class PostController extends GetxController {
  final name = ''.obs;
  final post = ''.obs;
  final profilepic = ''.obs;
  final postpics = <String>[].obs;
  final caption = ''.obs;
  final timestamp = ''.obs;
  final likes = ''.obs;
  final comments = ''.obs;
  final postsaved = false.obs;
  final hashtags = <String>[].obs;

  // Getters for observables
  String get getName => name.value;
  String get getPost => post.value;
  String get getProfilePic => profilepic.value;
  List<String> get getpostpics => postpics.toList(); // Return a copy of the list
  String get getCaption => caption.value;
  String get getTimestamp => timestamp.value;
  String get getLikes => likes.value;
  String get getComments => comments.value;
  bool get isPostSaved => postsaved.value;
  List<String> get getHashtags => hashtags.toList(); // Return a copy of the list

  // Setters for observables (optional)
  set setName(String value) => name.value = value;
  set setPost(String value) => post.value = value;
  set setProfilePic(String value) => profilepic.value = value;
  set setpostpics(List<String> value) => postpics.assignAll(value); // Replace the entire list
  set setCaption(String value) => caption.value = value;
  set setTimestamp(String value) => timestamp.value = value;
  set setLikes(String value) => likes.value = value;
  set setComments(String value) => comments.value = value;
  set setPostSaved(bool value) => postsaved.value = value;
  set setHashtags(List<String> value) => hashtags.assignAll(value); // Replace the entire list

  // Constructor for initialization
  PostController({
    required String name,
    required String post,
    required String profilepic,
    required String postpic,
    required String caption,
    required String timestamp,
    required String likes,
    required String comments,
    required bool postsaved,
    required List<String> hashtags,
  }) {
    this.name.value = name;
    this.post.value = post;
    this.profilepic.value = profilepic;
    this.postpics.assignAll(postpics);
    this.caption.value = caption;
    this.timestamp.value = timestamp;
    this.likes.value = likes;
    this.comments.value = comments;
    this.postsaved.value = postsaved;
    this.hashtags.assignAll(hashtags);
  }
}



