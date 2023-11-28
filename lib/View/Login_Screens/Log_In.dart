import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialmediaapp/View/Login_Screens/Sign_In.dart';
import '../../Components/BottomNavigationBar/MyBottomNavigationBar.dart';
import '../../ViewModels/loginViewModel.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final LogInMV = Get.put(LoginViewModel()) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.12,
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/signin.svg",
                  height: 220,
                  width: 220,
                ),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              const Align(alignment: Alignment.centerLeft,
                child: Text(
                  'To get started, first enter your phone, email\n address or @username',
                  style: TextStyle(
                    color: Colors.black,fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1)]),
                child: TextFormField(controller:LogInMV.emailController.value ,
                  decoration: InputDecoration(
                      hintText: "    Phone,email address,or username",
                      hintStyle: const TextStyle(color: Color(0XFF707070),
                        fontSize: 11,
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const SignIn());
                  // Get.to(() => BottomNavBarV2());
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
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}