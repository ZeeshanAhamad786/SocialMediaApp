
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../View/CreatePost/CreatePost.dart';
import '../View/ProfileMenuButton_Screens/SavedPosts.dart';
import '../Widgets/CustomDialog.dart';


class PersonalPost_MoreButtonController extends GetxController {
  // Add your controller logic here
  // For example, you can handle tap actions and update the UI
  void handleTapAction(int index,BuildContext context) {
    switch (index) {
      case 0:
      // Handle the "Saved" action
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => Saved_Posts()));

        break;
      case 1:
      // Handle the "Archive" action
        break;
      case 2:
      // Handle the "Hide Likes" action

        break;
      case 3:
      // Handle the "Turn off comments" action

        break;
      case 4:
      // Handle the "Report Post" action
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePost()),
          );
        break;
      case 6:
        CustomDialog.showcustomDialog(context,"Are you sure you want to Delete?","Delete","Cancel");

    // Add more cases as needed
    }
  }
}
