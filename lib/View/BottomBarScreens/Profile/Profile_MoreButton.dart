import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/View/BottomBarScreens/Home/SharePost.dart';

import '../../../Controllers/OtherUser_MoreButtonContoller.dart';
import '../../ProfileMenuButton_Screens/Draft.dart';
import '../../ProfileMenuButton_Screens/SavedPosts.dart';
import '../../Settings/BlockSetting.dart';
import '../../Settings/Setting_Privacy.dart';
import 'Profile Edit/Profile_Edit.dart';


class Profile_MoreButton extends StatelessWidget {
  final bool otherUserProfile; // Add this line

  final List<String> iconsforuserprofie = [
    'assets/share.svg',
    'assets/draft.svg',
    'assets/save_blue.svg',
    'assets/settings.svg',
    // Add more items as needed
  ];

  final List<String> textsforuserprofile = [
    'Share this Profile',
    'Draft',
    'Saved',
    'Settings and Privacy',
    // Add more items as needed
  ];

  final List<String> iconsforotherprofie = [
    'assets/report.svg',
    'assets/block.svg',
    'assets/unfollow.svg',
    'assets/sendMessage.svg',

    'assets/copy.svg',
    'assets/share.svg',
    // Add more items as needed
  ];

  final List<String> textsforotherprofile = [
    'Report',
    'Block',
    'Unfollow',
    'Send Message',

    'Copy profile URL',
    'Share this Profile',
    // Add more items as needed
  ];

  Profile_MoreButton({
    Key? key,
    required this.otherUserProfile, // Add this constructor parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (otherUserProfile) {
      return ForOtherProfile(context);
    } else {
      return ForUserProfile(context);
    }
  }

  Widget ForUserProfile(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.3, // Adjust the height as needed
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            height: 3,
            width: 90,
            color: Color(0xff707070),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: iconsforuserprofie.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: InkWell(
                    onTap: () {

                      if (textsforuserprofile[index] == 'Saved') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Saved_Posts()),
                        );
                      }
                      if (textsforuserprofile[index] == 'Draft') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Drafts()),
                        );
                      }
                      if (textsforuserprofile[index] == 'Share this Profile')

                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(
                                    25)), // Set circular border radius here
                          ),
                          context: context,
                          builder: (BuildContext context) => MyBottomSheet(),
                        );

                    },
                    child: Container(
                      height: 30,
                      child: ListTile(
                        leading: SvgPicture.asset(iconsforuserprofie[index]),
                        title: Text(
                          textsforuserprofile[index],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ForOtherProfile(BuildContext context) {
    return GetBuilder<Otheruser_MoreButtonController>(
        init: Otheruser_MoreButtonController(),
        builder: (controller) {
          return Container(
            height: 55 * iconsforotherprofie.length.toDouble(),
            // Adjust the height as needed
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 3,
                  width: 90,
                  color: Color(0xff707070),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: iconsforotherprofie.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: Container(
                          height: 30,
                          child: ListTile(
                            leading:
                                SvgPicture.asset(iconsforotherprofie[index]),
                            title: Text(
                              textsforotherprofile[index],
                              style: TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              controller.handleTapAction(index,context);

                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
