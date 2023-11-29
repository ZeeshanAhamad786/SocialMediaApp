import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/Utis/validations.dart';
import 'package:socialmediaapp/ViewModels/signUpViewModel.dart';
import 'PixkProfilePicture.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final registerVM = Get.put(RegisterViewModel());
  var isChecked = false.obs;

  bool isPasswordValid(String password) {
    return password.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios, size: 15),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  You'll need a Password",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Make sure it's 8 characters or more.",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
                SizedBox(height: Get.height * 0.06),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validations.validatePassword,
                  controller: registerVM.passwordController.value,
                  onChanged: (value) {
                    if (value.length >= 8) {
                      isChecked.value = true;
                    } else {
                      isChecked.value = false;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 10,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/Show.svg"),
                          const SizedBox(width: 10),
                          isChecked.value
                              ? Container(
                            height: 17,
                            width: 17,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                Border.all(color: Colors.blue)),
                            child: const Icon(Icons.check,
                                color: Colors.white, size: 15),
                          )
                              : Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: Get.height * 0.09),
                TextButton(
                  onPressed: () async {
                    if (isPasswordValid(
                        registerVM.passwordController.value.text)) {
                      // Set loading to true before starting the signup process
                      registerVM.loading.value = true;

                      // Simulate some async task (replace it with your signup logic)
                      await Future.delayed(Duration(seconds: 2));

                      // Set loading back to false after completing the process
                      registerVM.loading.value = false;

                      // Continue to the next screen or perform other actions
                      registerVM.signUp();
                    } else {
                      Get.snackbar('Error',
                          'Password must be at least 8 characters long');
                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.5,
                        ),
                      ],
                      color: Color(0xffAC83F6),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: registerVM.loading.value
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        "Next",
                        style:
                        TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
