import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controllers/ProfileController.dart';
import '../Home/PostsFeedScreen.dart';
import 'All_TAb.dart';


class PersonalPosts extends StatelessWidget {
  PersonalPosts({Key? key}) : super(key: key);
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // SizedBox(height: 60,),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                border: Border.all(color: Colors.grey.withOpacity(0.3))
            ),
            child: Column(
              children: [
                const SizedBox(height: 60,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(CupertinoIcons.left_chevron)),
                    const Text(
                      "Posts",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(height: 40, width: 40,)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TabBar(
                      labelColor: Colors.black,

                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(fontSize: 16),
                      indicatorColor: Color(0xffAC83F6),
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      indicatorWeight: 3,
                      tabs: [
                        Tab(text: 'Posts'),
                        Tab(text: 'Media'),
                        Tab(text: 'Like'),
                      ],
                    ),
                  ),
                  // Remove the fixed height for TabBarView
                  Expanded(
                    child: TabBarView(
                      children: [
                        PostFeedScreen(saved_posts_Screen: true, ispersonalpost: true,),
                        All_Tab(userprofile: controller.userProfile.value),
                        const Center(child: Text('Videos')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}