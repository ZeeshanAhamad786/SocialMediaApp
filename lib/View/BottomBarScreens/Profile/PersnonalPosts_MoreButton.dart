import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Controllers/PersonalPost_MoreButtonController.dart';
import '../../ProfileMenuButton_Screens/SavedPosts.dart';


class PersonalPosts_MoreButton extends StatelessWidget {
  final List<String> iconsforperonalposts = [
    'assets/save_blue.svg',
    'assets/archive.svg',
    'assets/hidecountlikes.svg',
    'assets/offcomments.svg',
    'assets/editProfile.svg',
    'assets/pin.svg',
    'assets/del.svg',
    // Add more items as needed
  ];

  final List<String> textsforperonalposts = [
    'Saved',
    'Archive',
    'Hide Like Counts',
    'Turn Off Commenting',
    'Edit',
    'Pin to your profile',
    'Delete',
    // Add more items as needed
  ];

  PersonalPosts_MoreButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ForPersonalPosts(context);
  }

  Widget ForPersonalPosts(BuildContext context) {
    return GetBuilder<PersonalPost_MoreButtonController>(
        init: PersonalPost_MoreButtonController(),
    builder: (controller) {
    return

    Container(
      height: 55 * iconsforperonalposts.length.toDouble(),
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
              itemCount: iconsforperonalposts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Container(
                    height: 30,
                    child: ListTile(
                      leading: SvgPicture.asset(iconsforperonalposts[index]),
                      title: Text(
                        textsforperonalposts[index],
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
    );});
  }
}
