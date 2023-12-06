import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/GetuserdataDataController.dart';
import '../../Controllers/ProfileController.dart';
import '../../View/Balance_Sheets/CurrentBalance.dart';
import '../../View/BottomBarScreens/Profile/Profile.dart';
import '../../View/BottomBarScreens/Profile/ProfileWidgets.dart';
import '../../View/ProfileMenuButton_Screens/SavedPosts.dart';
import '../../View/Settings/Setting_Privacy.dart';
import '../../Widgets/PicPost_Widget.dart';


class MyDrawer extends StatelessWidget {
  final List<String> profileIcons = [
    "assets/Iconly-Bulk-Profile.svg",
    "assets/Bookmark.svg",
    "assets/Setting.svg",
    "assets/Bulk-Wallet.svg",
  ];

  final List<String> names = ["View Profile", "Saved", "Setting and privacy", "Wallet"];
  final ProfileController controller = Get.put(ProfileController());

  // You can pass any required data through the constructor

  @override
  Widget build(BuildContext context) {
    GetUserDataController getUserDataController =
    Get.put(GetUserDataController());
    return Drawer(
      backgroundColor: Colors.white,
      shape: OutlineInputBorder(
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(20),
        // ),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ProfilePicWidget(
                    picType: 'network',
                    getUserDataController.getUserDataRxModel.value!.profileimage, 80, 80),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(   getUserDataController.getUserDataRxModel.value?.name ?? '',),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Accountdata_Widget("Post", "1458"), // Replace 100 with actual number
                  FutureBuilder<List<String>>(
                    future: controller.getFollowers(FirebaseAuth.instance.currentUser!.uid),
                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('Press button to start.');
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Text('Awaiting result...');
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Use the snapshot.data to get the list of followers
                            List<String> followers = snapshot.data ?? [];

                            return Column(
                              children: [
                                Text(
                                  ' ${followers.length}', // Display the count of followers
                                  style:  const TextStyle(color:Colors.black,fontSize: 17),textAlign: TextAlign.center,
                                ),const Text(
                                  'Followers', // Display the count of followers
                                  style: TextStyle(color:Colors.grey,fontSize: 12 ),textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          }
                      }
                    },
                  ), // Replace 200 with actual number
                  FutureBuilder<List<String>>(
                    future: controller.getFollowing(FirebaseAuth.instance.currentUser!.uid),
                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('Press button to start.');
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Text('Awaiting result...');
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Use the snapshot.data to get the list of followers
                            List<String> followers = snapshot.data ?? [];

                            return Column(
                              children: [
                                Text(
                                  ' ${followers.length}', // Display the count of followers
                                  style:  const TextStyle(color:Colors.black,fontSize: 17),textAlign: TextAlign.center,
                                ),const Text(
                                  'Followers', // Display the count of followers
                                  style: TextStyle(color:Colors.grey,fontSize: 12 ),textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          }
                      }
                    },
                  ), // Replace 300 with actual number
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileIcons.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: SvgPicture.asset(profileIcons[index]),
                    title: Text(names[index],style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                    onTap: () {
                      if(index==0){
                        Navigator.pop(context);
                       Get.to(
                           Profile(postId: '',
                             otherUserProfile: false,profileName:  getUserDataController.getUserDataRxModel.value?.name ?? '',profileImage:   getUserDataController.getUserDataRxModel.value!.profileimage,userId:  getUserDataController.getUserDataRxModel.value?.userId ?? '',)) ;
                      }
                      if(index==1){
                        Navigator.pop(context);
                        // Get.to(Saved_Posts()) ;
                      }
                      if(index==2){
                        Navigator.pop(context);
                        Get.to(SettingPrivacy()) ;
                      }
                      if(index==3){
                        // Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CurrentBalance()),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
