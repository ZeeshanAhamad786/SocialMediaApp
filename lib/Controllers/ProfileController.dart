import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../Models/ProfileModels.dart';


class ProfileController extends GetxController {

  final Rx<ProfileModel> userProfile = ProfileModel(backgroundImage: "",userId: '',activeChatUsers: [],followers: '',
    profileimage: 'assets/profilepic.png',
    name: "Minha Anjum",
    dob: "29/6/2002",
    location: 'Lahore',
    bio: "Graphic Designer/\nAnimator/Videographer",
    numberOfPosts: "1458",
    numberOfFollowers: "321",
    numberOfFollowings: "154",
    posts: [
      "assets/profilepic.png",
      "assets/model1.jpg",
      "assets/model2.jpg",
      'assets/model3.jpg',
      'assets/model4.jpg',
      // ... add more images
    ],
  ).obs;

  // Function to follow a user
  void followUser(String followerId, String followingId) async {
    // Add to Followers
    await FirebaseFirestore.instance.collection('Followers').add({
      'userId': followerId,
      'followingId': followingId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Add to Following
    await FirebaseFirestore.instance.collection('Following').add({
      'userId': followingId,
      'followerId': followerId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

// Function to unfollow a user
  void unfollowUser(String followerId, String followingId) async {
    // Remove from Followers
    QuerySnapshot followerDocs = await FirebaseFirestore.instance
        .collection('Followers')
        .where('userId', isEqualTo: followerId)
        .where('followingId', isEqualTo: followingId)
        .get();

    followerDocs.docs.forEach((doc) {
      doc.reference.delete();
    });

    // Remove from Following
    QuerySnapshot followingDocs = await FirebaseFirestore.instance
        .collection('Following')
        .where('userId', isEqualTo: followingId)
        .where('followerId', isEqualTo: followerId)
        .get();

    followingDocs.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

// Function to get followers of a user
  Future<List<String>> getFollowers(String userId) async {
    QuerySnapshot followers = await FirebaseFirestore.instance
        .collection('Followers')
        .where('followingId', isEqualTo: userId)
        .get();

    return followers.docs.map((doc) => doc['userId']).cast<String>().toList();
  }

// Function to get users a user is following
  Future<List<String>> getFollowing(String userId) async {
    QuerySnapshot following = await FirebaseFirestore.instance
        .collection('Following')
        .where('followerId', isEqualTo: userId)
        .get();

    return following.docs.map((doc) => doc['userId']).cast<String>().toList();
  }


}
