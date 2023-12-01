import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Utis/firebase.dart';
import 'GetuserdataDataController.dart';

class ProfileEditController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController dOBController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? profileImageUrl;
  String? backgroundImage;

  Rx<File?> selectedCoverImage = Rx<File?>(null);
  Rx<File?> selectedProfileImage = Rx<File?>(null);

  Future<void> updateProfileHandler({
    userName,
    userDOB,
    userLocation,
    userBio,
  }) async {
    if (nameController.text.isNotEmpty &&
        dOBController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        bioController.text.isNotEmpty) {
      try {
        if (selectedProfileImage.value != null && selectedCoverImage.value != null) {
          await updateProfileAndBackgroundImages(
            userName: userName,
            userDOB: userDOB,
            userLocation: userLocation,
            userBio: userBio,
          );
        } else if (selectedProfileImage.value != null) {
          await updateProfileImage(
            userName: userName,
            userDOB: userDOB,
            userLocation: userLocation,
            userBio: userBio,
          );
        } else if (selectedCoverImage.value != null) {
          await updateBackgroundImage(
            userName: userName,
            userDOB: userDOB,
            userLocation: userLocation,
            userBio: userBio,
          );
        } else {
          Get.snackbar('Error', 'Please select an image to update.');
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.toString());
      }
    } else {
      Get.snackbar('Required', 'All fields are Required');
    }
  }

  Future<void> updateProfileAndBackgroundImages({
    userName,
    userDOB,
    userLocation,
    userBio,
  }) async {
    await uploadProfileImageToFirebaseStorage(
      selectedProfileImage.value!,
      userName: userName,
      userDOB: userDOB,
      userLocation: userLocation,
      userBio: userBio,
    );

    await uploadBackgroundImageToFirebaseStorage(
      selectedCoverImage.value!,
      userName: userName,
      userDOB: userDOB,
      userLocation: userLocation,
      userBio: userBio,
    );
  }

  Future<void> updateProfileImage({
    userName,
    userDOB,
    userLocation,
    userBio,
  }) async {
    await uploadProfileImageToFirebaseStorage(
      selectedProfileImage.value!,
      userName: userName,
      userDOB: userDOB,
      userLocation: userLocation,
      userBio: userBio,
    );
  }

  Future<void> updateBackgroundImage({
    userName,
    userDOB,
    userLocation,
    userBio,
  }) async {
    await uploadBackgroundImageToFirebaseStorage(
      selectedCoverImage.value!,
      userName: userName,
      userDOB: userDOB,
      userLocation: userLocation,
      userBio: userBio,
    );
  }

  Future<void> updateUserData({
    profileImage,
    backgroundImage,
    userName,
    userDOB,
    userBio,
    userLocation,
  }) async {
    final dataToUpdate = {
      if (profileImage != null) 'photoUrl': profileImage,
      if (backgroundImage != null) 'backgroundImage': backgroundImage,
      'name': userName,
      "userBio": userBio,
      "userLocation": userLocation,
      'dob': userDOB,
    };

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(dataToUpdate)
        .then((value) {
      getUserDataController.getUserData();
      Get.snackbar('Success', 'User Update Successfully.');

      print("User Updated");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  Future<void> uploadProfileImageToFirebaseStorage(
      File profileImage, {
        userName,
        userDOB,
        userBio,
        userLocation,
      }) async {
    try {
      final fileProfileName = '${auth.currentUser!.uid}_image.jpg';
      final Reference storageProfileRef =
      storage.ref().child('profile_images_folder/$fileProfileName');
      await storageProfileRef.putFile(profileImage);

      profileImageUrl = await storageProfileRef.getDownloadURL();
      print('Download URL for $fileProfileName: $profileImageUrl');

      await updateUserData(
        profileImage: profileImageUrl,
        userName: userName,
        userBio: userBio,
        userLocation: userLocation,
        userDOB: userDOB,
        backgroundImage: null,
      );
    } catch (e) {
      print('Error uploading profile image to Firebase Storage: $e');
    }
  }

  Future<void> uploadBackgroundImageToFirebaseStorage(
      File backgroundImage, {
        profileImage,
        userName,
        userDOB,
        userBio,
        userLocation,
      }) async {
    try {
      final fileName = '${auth.currentUser!.uid}_background_image.jpg';
      final Reference storageRef =
      storage.ref().child('background_images_folder/$fileName');
      await storageRef.putFile(backgroundImage);

      backgroundImage = (await storageRef.getDownloadURL()) as File;
      print('Download URL for $fileName: $backgroundImage');

      await updateUserData(
        profileImage: null,
        userName: userName,
        userBio: userBio,
        userLocation: userLocation,
        userDOB: userDOB,
        backgroundImage: backgroundImage,
      );
    } catch (e) {
      print('Error uploading background image to Firebase Storage: $e');
    }
  }



  selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd MMM yyyy').format(picked);
      dOBController.text = formattedDate.toString();
    }
  }

  coverPickedImage() async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedCoverImage.value = File(pickedFile.path);
        log(selectedCoverImage.value.toString());
      } else {
        Get.snackbar("No Image", "Please Select Image");
      }
    } catch (e) {
      Get.snackbar("An Error", " ${e.toString()}");
    }
  }

  profilePickedImage() async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedProfileImage.value = File(pickedFile.path);
        log(selectedProfileImage.value.toString());
      } else {
        Get.snackbar("No Image", "Please Select Image");
      }
    } catch (e) {
      Get.snackbar("An Error", " ${e.toString()}");
    }
  }
}
