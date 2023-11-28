import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import '../Components/BottomNavigationBar/MyBottomNavigationBar.dart';
import '../View/Chat%20screens/MainChatScreens.dart';
import '../View/Login_Screens/Log_In.dart';

class GoogleSignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled Google Sign-In process


        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
          credential);
      final User? user = userCredential.user;

      if (user != null) {
        // User logged in successfully
        // Check if the user exists in your database
        bool isExistingUser = await checkIfUserExists(user.email);

        if (isExistingUser) {
          // If user exists, navigate to MainChatScreens
          Get.offAll(() => BottomNavBarV2());
          log('MainChatScreens()');

        } else {
          // If user does not exist, navigate to Login screen
          Get.offAll(() => LogIn());
          log(' LogIn()');

        }
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  Future<bool> checkIfUserExists(String? email) async {
    if (email != null) {
      // Implement logic to check if the user with the given email exists in your database
      // Return true if the user exists, false otherwise
      return true; // Replace this with your actual logic
    } else {
      // Handle case where email is null (optional)
      return false;
    }
  }
}
