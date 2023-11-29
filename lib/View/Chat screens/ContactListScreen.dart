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
    final Size size =MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            SizedBox(height: Get.height * 0.1,),
            Align(alignment: Alignment.centerLeft,
                child: InkWell(onTap: () {
                  Navigator.pop(context);
                },
                    child: Icon(Icons.arrow_back_ios, size: 15,))),
            SizedBox(height: size.height/50,),
            SvgPicture.asset("assets/contact.svg"),
            Text("See who's on your Contact"),
            Text("Syncing your contacts is on way to find people to follow and build your timeline "),
            Row(children: [
              Icon(Icons.person_off),
              Text("You decide who to follow"),
            ],
            ),
            Row(children: [
              Icon(Icons.person_off),
              Text("You decide who to follow"),
            ],
            ),
            Row(children: [
              Icon(Icons.person_off),
              Text("You decide who to follow"),
            ],
            ),
            Text("Step into a world of endless possibilities and connections with our social media platform. From sharing life's highlightsto exploring new horizons, our app is your gateway to a vibrantsocial experience. Start connecting today and let thejourney unfold!" ),
            CustomButton(
              text: 'Continue', onPressed: () {  _showBottomSheetSlider(context); },

              //   onPressed: ()=>registerVM.signUp(),
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
