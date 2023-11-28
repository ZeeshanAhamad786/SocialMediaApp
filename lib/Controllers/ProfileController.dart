import 'package:get/get.dart';
import '../Models/ProfileModels.dart';
import '../Utis/firebase.dart'; // Import the Firebase instance

class ProfileController extends GetxController {
  // Define your ProfileModel as an observable object
  final Rx<ProfileModel> userProfile = ProfileModel(backgroundImage: "",
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


}
