import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/View/Login_Screens/Log_In.dart';

import '../../Controllers/Google_Sign_In.dart';
import '../CreateAccount/SignUp.dart';

class ContinueWithGoogle extends StatefulWidget {
  @override
  State<ContinueWithGoogle> createState() => _ContinueWithGoogleState();
}

class _ContinueWithGoogleState extends State<ContinueWithGoogle> {
  final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(height: MediaQuery.of(context).size.height*0.12,),
              Center(
                child: SvgPicture.asset(
                  "assets/signin.svg",
                  height: 220,
                  width: 220,
                ),
              ),
              SizedBox(height: Get.height * 0.1),
              Align(alignment: Alignment.centerLeft,
                child: Text(
                  "See What's happening in the world right now.",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              ElevatedButton.icon(
                onPressed: () async {
                  await _googleSignInController.signInWithGoogle();
                },
                icon: SvgPicture.asset("assets/google.svg", height: 24, width: 24),
                label: Text(
                  "Continue with Google",
                  style: TextStyle(color: Color(0xffAC83F6), fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.of(context).size.width * 0.65, 40),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              SizedBox(
                height: Get.height*0.01,
              ),
              TextButton(
                onPressed: () {

                  Get.to(SignUp());
                },
                child: Container(
                  height: 40,
                  width:  MediaQuery.of(context).size.width * 0.65,
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
                    child: Text(
                      "Create account",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'By signing up you, agree to our ',
                      style: TextStyle(fontSize: 13, color: Color(0xff707070)),
                    ),
                    TextSpan(
                      text: 'Terms Privacy',
                      style: TextStyle(fontSize: 13, color: Color(0xff3EA7FF)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.001),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Policy ", style: TextStyle(color: Color(0xff3EA7FF), fontSize: 13)),
                  Text("and", style: TextStyle(color: Color(0xff707070), fontSize: 11)),
                  Text(" Cookie Use", style: TextStyle(color: Color(0xff3EA7FF), fontSize: 13)),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account?", style: TextStyle(fontSize: 13, color: Color(0xff707070))),
                  InkWell(
                    onTap: () {
                      Get.to(() => LogIn());
                    },
                    child: Text(" Log In", style: TextStyle(color: Color(0xff3EA7FF), fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}