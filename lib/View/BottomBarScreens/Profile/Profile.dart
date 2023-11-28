import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../Controllers/GetuserdataDataController.dart';
import '../../../Controllers/ProfileController.dart';

import '../../../Widgets/CustomButton.dart';
import '../../../Widgets/PicPost_Widget.dart';
import '../../../Widgets/PostFeedScreenForProfileScreen.dart';
import '../Home/PostsFeedScreen.dart';
import 'All_Tab.dart';
import 'Profile Edit/Profile_Edit.dart';
import 'ProfileWidgets.dart';
import 'Profile_MoreButton.dart';


class Profile extends StatefulWidget {
  final bool otherUserProfile;

  Profile({Key? key, required this.otherUserProfile}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController controller = Get.put(ProfileController());

  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
 // Create and register a new instance of GetUserDataController
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 27),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.left_chevron,
                          color: Colors.black,
                        ),
                    iconSize: 18,),
                  ),
              automaticallyImplyLeading: false,
              expandedHeight: 400,
              pinned: true,
              title: innerBoxIsScrolled && (widget.otherUserProfile || !widget.otherUserProfile)
                  ? Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                          ],
                        ),
                        Expanded(child: Align(
                            alignment: Alignment.centerRight,
                            child: widget.otherUserProfile ? Container(
                                height: 25,
                                width: 80,
                                child: CustomButton(text: 'Follow', onPressed: () {  },)) :


                            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {  },iconSize: 20,)
                        ))
                      ],
                    ),
                  )
                  : null,

              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    final userProfile = controller.userProfile.value;

                    return Stack(
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(getUserDataController.getUserDataRxModel.value!.backgroundImage,),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 50),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(
                                                25)), // Set circular border radius here
                                      ),
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Profile_MoreButton(
                                        otherUserProfile: widget.otherUserProfile,
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ProfilePicWidget(
                                      picType: 'network',
                                      getUserDataController.getUserDataRxModel.value!.profileimage,
                                      95,
                                      95,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(

                                          getUserDataController.getUserDataRxModel.value?.name ?? '', // Use null-aware operators

                                          style: const TextStyle(
                                            color: Color(0xff3EA7FF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        if (widget.otherUserProfile)
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                height: 30,
                                                width: 95,
                                                child: CustomButton(
                                                  text: 'Message',
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (widget.otherUserProfile)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Container(
                                              height: 30,
                                              width: 80,
                                              child: CustomButton(
                                                text: 'Follow',
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        if (!widget.otherUserProfile)
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                height: 30,
                                                width: 120,
                                                child: CustomButton(
                                                  text: 'Edit Profile',
                                                  onPressed: () {
                                                    Get.to(ProfileEdit());
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      getUserDataController.getUserDataRxModel.value!.bio,
                                      style: const TextStyle(fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Accountdata_Widget(
                                    "Post",
                                    userProfile.numberOfPosts,
                                  ),
                                ),
                                Expanded(
                                  child: Accountdata_Widget(
                                    "Followers",
                                    userProfile.numberOfFollowers,
                                  ),
                                ),
                                Expanded(
                                  child: Accountdata_Widget(
                                    "Following",
                                    userProfile.numberOfFollowings,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 60),
                            if (widget.otherUserProfile) const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
              forceElevated: innerBoxIsScrolled,
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 14,
                ),
                indicatorColor: Color(0xffAC83F6),
                padding: EdgeInsets.symmetric(horizontal: 40),
                indicatorWeight: 3,
                tabs: [
                  Tab(text: 'Post'),
                  Tab(text: 'Media'),
                  Tab(text: 'Like'),
                ],
              ),
            ),
          ],
          body: Container(
            height: 175 * controller.userProfile.value.posts.length.toDouble(),
            child: TabBarView(
              children: [
                ListViewBuilder(
                  saved_posts_Screen: false,
                  ispersonalpost: !widget.otherUserProfile,
                ),

                All_Tab(userprofile: controller.userProfile.value),
                PostFeedScreen(
                  saved_posts_Screen: false,
                  ispersonalpost: !widget.otherUserProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
