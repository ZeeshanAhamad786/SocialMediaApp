import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Controllers/ProfileController.dart';
import '../BottomBarScreens/Profile/All_TAb.dart';
class Drafts extends StatelessWidget {
  Drafts({Key? key}) : super(key: key);
  // final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.left_chevron),iconSize: 18,
                    ),
                    Text(
                      "Draft",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 40, width: 40,),
                  ],
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: GridView.builder(
          //     shrinkWrap: true,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 5.0,
          //       mainAxisSpacing: 8.0,
          //     ),
          //     itemCount: controller.userProfile.value.posts.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       print(controller.userProfile.value.posts[index]);
          //       return Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(15),
          //           image: DecorationImage(
          //             image: AssetImage(controller.userProfile.value.posts[index]),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.all(15.0),
          //           child: Align(
          //             alignment: Alignment.topRight,
          //             child: SvgPicture.asset('assets/album.svg'),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
