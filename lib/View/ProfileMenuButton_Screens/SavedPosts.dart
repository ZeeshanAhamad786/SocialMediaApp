import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/ProfileController.dart';
import '../BottomBarScreens/Home/PostsFeedScreen.dart';
import '../BottomBarScreens/Profile/All_TAb.dart';


class Saved_Posts extends StatelessWidget {
   Saved_Posts({Key? key}) : super(key: key);
  // final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // SizedBox(height: 60,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
              border: Border.all(color: Colors.grey.withOpacity(0.3))
            ),
            child: Column(
              children: [
                SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(CupertinoIcons.left_chevron),iconSize: 18,),
                    Text(
                      "Saved",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    SizedBox(height: 40, width: 40,),
                    // Icon(Icons.more_vert)
                  ],
                ),
              ],
            ),
          ),

                  // Remove the fixed height for TabBarView
                  Flexible(
                      child: PostFeedScreen(saved_posts_Screen: true, ispersonalpost: false,))

                ],
              ),

    );
  }
}
