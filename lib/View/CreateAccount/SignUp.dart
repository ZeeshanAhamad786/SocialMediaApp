import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/Utis/validations.dart';
import 'package:socialmediaapp/View/CreateAccount/PasswordScreen.dart';
import 'package:socialmediaapp/ViewModels/signUpViewModel.dart';
import '../Login_Screens/CustomTextFieldSignUp.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final registerVM = Get.put(RegisterViewModel());
  late DateTime _selectedDate = DateTime.now(); // Initialize _selectedDate

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        registerVM.dobController.value.text =
        "${picked.day}-${picked.month}-${picked.year}"; // Update the text field with the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerVM.globalSignUpKey,
      child: Scaffold(backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Center(
                  child: SvgPicture.asset(
                    "assets/signup.svg",
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomTextField(
                  validation: Validations.validateName,
                  hintText: " Name",
                  controller: registerVM.nameController.value,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomTextField(
                  validation: Validations.validateEmail,
                  hintText: " Phone number or Email address",
                  controller: registerVM.emailController.value,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    height: 38,
                    width: MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                            style: const TextStyle(fontSize: 10, color: Color(0xff707070)),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.07,
                ),
                TextButton(
                  onPressed: () {
                    if (registerVM.nameController.value.text.isEmpty ||
                        registerVM.emailController.value.text.isEmpty ||
                        registerVM.dobController.value.text.isEmpty) {
                      // Show an error message or snackbar indicating that all fields are required
                      // You can use Get.snackbar or any other method to display the error message
                      Get.snackbar('Error', 'All fields are required');

                    } else {
                      print("SignUp Successful");
                     Navigator.push(context, MaterialPageRoute(builder: (_)=>PasswordScreen()));

                    }
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.5,
                        ),
                      ],
                      color: Color(0xffAC83F6),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 13),
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
