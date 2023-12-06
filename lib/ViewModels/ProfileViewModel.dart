import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/ProfileModels.dart';

class ProfileViewModel extends GetxController {
  final profile = ProfileModel(backgroundImage: "",userId: '',activeChatUsers: [],followers: '',
    profileimage: '',
    name: '',
    dob: '',
    bio: '',
    location: '',
    numberOfPosts: '',
    numberOfFollowers: '',
    numberOfFollowings: '',
    posts: [],
  ).obs;


  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // Check if the field exists before accessing its value
        profile.value = ProfileModel(backgroundImage: "",userId: '',activeChatUsers: [],
          followers: '',
          profileimage: userDoc.get('profileImage') ?? "", // Check 'profileImage' field
          name: userDoc.get('name') ?? "", // Check 'name' field
          dob: userDoc.get('dob') ?? "", // Check 'dob' field
          location: userDoc.get('location') ?? "", // Check 'location' field
          bio: userDoc.get('bio') ?? "", // Check 'bio' field
          numberOfPosts: userDoc.get('numberOfPosts') ?? "", // Check 'numberOfPosts' field
          numberOfFollowers: userDoc.get('numberOfFollowers') ?? "", // Check 'numberOfFollowers' field
          numberOfFollowings: userDoc.get('numberOfFollowings') ?? "", // Check 'numberOfFollowings' field
          posts: List<String>.from(userDoc.get('posts') ?? []), // Check 'posts' field
        );
      } else {
        // Handle the case when the document does not exist
        print('User document does not exist');
        // You can set default values or show an error message to the user
        // For example:
        // profile.value = ProfileModel();
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }



  Future<void> updateUserData({
    required String userId,
    String? name,
    String? dob,
    String? location,
    String? bio,
  }) async {
    try {
      DocumentReference userDocRef =
      FirebaseFirestore.instance.collection('users').doc(userId);

      // Check if the document exists before updating
      DocumentSnapshot<Object?> userDoc = await userDocRef.get();

      if (userDoc.exists) {
        // Document exists, update data
        await userDocRef.update({
          'name': name ?? profile.value.name,
          'dob': dob ?? profile.value.dob,
          'location': location ?? profile.value.location,
          'bio': bio ?? profile.value.bio,
        });
        print('User data saved successfully');
      } else {
        // Document does not exist, create a new one
        await userDocRef.set({
          'name': name ?? profile.value.name,
          'dob': dob ?? profile.value.dob,
          'location': location ?? profile.value.location,
          'bio': bio ?? profile.value.bio,
        });
        print('New user document created and data saved successfully');
      }
    } catch (e) {
      print('Error saving user data: $e');
    }
  }


}
