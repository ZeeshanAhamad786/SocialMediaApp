import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/GetuserdataDataController.dart';
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ProfilePicWidget(
                    picType: 'network',
                    getUserDataController.getUserDataRxModel.value!.profileimage, 80, 80),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(   getUserDataController.getUserDataRxModel.value?.name ?? '',),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Accountdata_Widget("Post", "1458"), // Replace 100 with actual number
                  Accountdata_Widget("Followers", "321"), // Replace 200 with actual number
                  Accountdata_Widget("Following", "154"), // Replace 300 with actual number
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: profileIcons.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: SvgPicture.asset(profileIcons[index]),
                    title: Text(names[index],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                    onTap: () {
                      if(index==0){
                        Navigator.pop(context);
                       Get.to(Profile(otherUserProfile: false,)) ;
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
