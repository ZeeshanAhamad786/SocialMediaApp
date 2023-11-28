
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../View/BottomBarScreens/Home/SharePost.dart';
import '../Widgets/CustomDialog.dart';


class FeedPost_MoreButtonController extends GetxController {
  // Add your controller logic here
  // For example, you can handle tap actions and update the UI
  void handleTapAction(int index,BuildContext context) {
    switch (index) {
      case 0:
      // Handle the "Share this post" action
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
        break;
      case 1:
      // Handle the "Save to watch later" action
        break;
      case 2:
      // Handle the "Unfollow" action
        CustomDialog.showcustomDialog(context,"Are you sure you want to Unfollow?","Unfollow","Cancel");

        break;
      case 3:
      // Handle the "Hide Post" action
        CustomDialog.showcustomDialog(context,"Are you sure you want to Hide Post?","Hide","Cancel");

        break;
      case 4:
      // Handle the "Report Post" action
        CustomDialog.showcustomDialog(context,"Are you sure you want to Report?","Report","Cancel");

        break;
    // Add more cases as needed
    }
  }
}
