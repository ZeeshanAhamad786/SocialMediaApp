import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Widgets/CustomButton.dart';
import 'contactBottomScreen.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(children: [
            SizedBox(
              height: Get.height * 0.1,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                    ))),
            SizedBox(
              height: size.height / 50,
            ),
            SvgPicture.asset("assets/contact.svg"),
            SizedBox(
              height: size.height / 50,
            ),
            Align(alignment: Alignment.centerLeft,
                child: Text("      See who's on your Contact", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
            SizedBox(
              height: size.height / 50,
            ),
            Text(
                "Syncing your contacts is on way to find people to follow and build \n\nyour timeline ",
                style: TextStyle(fontSize: 10)),
            SizedBox(
              height: size.height / 50,
            ),
            Row(
              children: [
                Transform.scale(
                    scale: 0.8,
                    child: SvgPicture.asset("assets/Light-Pro.svg")),
                SizedBox(width: 12,),
                Text("You decide who to follow",
                    style: TextStyle(fontSize: 13, color: Colors.black)),
              ],
            ),
            SizedBox(
              height: size.height / 50,
            ),
            Row(
              children: [
                Transform.scale(
                    scale: 0.8,
                    child: SvgPicture.asset("assets/Light-Swap.svg")),
                SizedBox(width: 12,),
                Text("Get notified when someone you know joins ",
                    style: TextStyle(fontSize: 13, color: Colors.black)),
              ],
            ),
            SizedBox(
              height: size.height / 50,
            ),
            Row(
              children: [
                Transform.scale(
                    scale: 0.8,
                    child: SvgPicture.asset("assets/line-icon.svg")),
                SizedBox(width: 12,),
                Text("Turn off syncing at any time",
                    style: TextStyle(fontSize: 13, color: Colors.black)),
              ],
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Text(
                "Step into a world of endless possibilities and connections with our social media platform. From sharing life's highlightsto exploring new horizons, our app is your gateway to a vibrantsocial experience. Start connecting today and let thejourney unfold!",
                style: TextStyle(fontSize: 11, color: Colors.grey)),
            SizedBox(
              height: size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: CustomButton(
                text: 'Continue',
                onPressed: () {
                  _showBottomSheetSlider(context);
                },

                //   onPressed: ()=>registerVM.signUp(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _showBottomSheetSlider(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Expanded(child: contactBottomList()),
              // Add your content here
            ],
          ),
        );
      },
    );
  }
}
