import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Balance_Sheets/CurrentBalance.dart';
import '../BottomBarScreens/Home/Home.dart';
class DialCall_Widget extends StatelessWidget {
  const DialCall_Widget({Key? key}) : super(key: key);


  backToHome(){
    Get.offAll(Home());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
       return backToHome();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 16),
                  onTap: () {
                    Get.offAll(Home());
                  },
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                    boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 1)],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here",
                      hintStyle: const TextStyle(color: Color(0xffD8D8D8), fontSize: 12),
                      contentPadding: const EdgeInsets.all(8),
                      prefixIcon: Transform.scale(
                        scale: 0.3,
                        child: SvgPicture.asset('assets/Bulk-Search.svg'),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {

                    Get.to(const CurrentBalance());
                    // _showBottomSlider(context);
                  },
                  child: SvgPicture.asset("assets/dot.svg"),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
              color: Colors.white,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Minutes left for International calls",
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  "78.6 min",
                  style: TextStyle(color: Color(0xffAC83F6), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: DialPad(
              outputMask: "(000) 000-0000",
              hideSubtitle: true,
              backspaceButtonIconColor: Colors.red,
              buttonTextColor: Colors.black,
              dialOutputTextColor: Colors.black,
              makeCall: (number) {
                print(number);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSlider(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                 SvgPicture.asset("assets/Bulk-Swap.svg") ,// Your icon here
                  const SizedBox(width: 20),
                  const Text('Top Up your account',style: TextStyle(color: Color(0xffAC83F6))),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
        SvgPicture.asset("assets/3 User.svg") ,
                  const SizedBox(width: 20),
                  const Text('Conference Call',style: TextStyle(color: Colors.black)),
                ],
              ),
              // Add more rows with icons and text as needed
            ],
          ),
        );
      },
    );
  }
}
