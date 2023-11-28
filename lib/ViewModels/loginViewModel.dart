import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Services/authServices.dart';
import '../Components/BottomNavigationBar/MyBottomNavigationBar.dart';
import '../Utis/utils.dart';

class LoginViewModel extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  RxBool loading = false.obs;

  void logIn() async {
    loading.value = true;
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.value.text.trim(),
        password: passwordController.value.text.trim(),
      );

      if (userCredential.user != null) {
        User user = userCredential.user!;
        String userId = user.uid;
        print('User ID: $userId');
        // Navigate to the desired screen after successful login
        Get.offAll(() => BottomNavBarV2());
        print("Next Screen");
      } else {
        // Handle the case where userCredential.user is null
        Utils.snackBar('Login Error', 'Invalid credentials. Please try again.');
      }
    } catch (e) {
      // Handle login errors
      String errorMessage = _authService.handleFirebaseAuthError(e.toString());
      Utils.snackBar('Login Error', errorMessage);
    } finally {
      loading.value = false;
    }
  }
}