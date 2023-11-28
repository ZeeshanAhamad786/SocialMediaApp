import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/View/CreateAccount/PasswordScreen.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({Key? key}) : super(key: key);

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          SizedBox(height: Get.height*0.1,),
          Align(alignment: Alignment.centerLeft,
              child: InkWell(onTap: () {
                Get.back();
              },
                  child: Icon(Icons.arrow_back_ios, size: 15,))),
          SizedBox(height: Get.height*0.02,),
          Align(alignment: Alignment.centerLeft,
              child: Text("  We sent you a code",style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w400),)),
          SizedBox(height: Get.height*0.01,),
          Align(alignment: Alignment.centerLeft,
              child: Text("Enter it below to verify Imran12sh@gmail.com",style: TextStyle(color: Colors.black,fontSize: 10),)),
          SizedBox(height: Get.height*0.06,),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1)]),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Verification Code",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7),
                    fontSize: 10,
                  ),

                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(height: Get.height*0.02,),
          Align(alignment: Alignment.centerLeft,
              child: Text("Don't Receive an Email ?",style: TextStyle(fontSize: 8, color: Color(0xff3EA7FF),fontWeight: FontWeight.w400),)),
          SizedBox(
            height: Get.height * 0.09,
          ),
          TextButton(
            onPressed: () {
              Get.to(() => PasswordScreen());
              // Get.to(() => BottomNavBarV2());
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
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
