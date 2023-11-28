import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Widgets/CustomDialog.dart';
import '../BottomBarScreens/Profile/Profile Edit/Profile_Edit.dart';
import 'BlockSetting.dart';

class SettingPrivacy extends StatefulWidget {
  const SettingPrivacy({Key? key}) : super(key: key);

  @override
  State<SettingPrivacy> createState() => _SettingPrivacyState();
}

class _SettingPrivacyState extends State<SettingPrivacy> {
  final RxBool notificationSwitchValue = true.obs;
  final RxBool soundNotificationSwitchValue = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 14,
                      ),
                    ),
                    Text(
                      "Setting Privacy",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 40,width: 40,)
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 5, // Updated to 6 items
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Second item
                  return ListTile(
                    leading: SvgPicture.asset("assets/Square.svg"),
                    title: Text("Edit Profile",style: TextStyle( color: Colors.black,fontSize: 12)),
                    onTap: (){Get.to(ProfileEdit());},
                  );
                } else if (index == 1) {
                  // Third item with notification switch
                  return ListTile(
                    leading: SvgPicture.asset("assets/notification.svg",color: Colors.blue,height: 20,width: 20,),
                    title: Text("Notifications", style: TextStyle(color: Colors.black,fontSize: 12)),
                    trailing: Transform.scale(scale: 0.8,
                      child: Obx(() => Switch(
                        value: notificationSwitchValue.value,
                        onChanged: (newValue) {
                          notificationSwitchValue.value = newValue;
                          // Perform any other operations based on the switch value here
                        },
                        inactiveTrackColor: Colors.white,
                        activeColor: Colors.blue,
                      )),
                    ),
                  );
                } else if (index == 2) {
                  // Fourth item with sound notification switch
                  return ListTile(
                    leading: SvgPicture.asset("assets/notification.svg",color: Colors.blue,height: 20,width: 20,),
                    title: Text("Sound Notifications", style: TextStyle(color: Colors.black,fontSize: 12)),
                    trailing: Transform.scale(scale: 0.8,
                      child: Obx(() => Switch(
                        value: soundNotificationSwitchValue.value,
                        onChanged: (newValue) {
                          soundNotificationSwitchValue.value = newValue;
                          // Perform any other operations based on the switch value here
                        },
                        inactiveTrackColor: Colors.white,
                        activeColor: Colors.blue,
                      )),
                    ),
                  );
                } else if (index == 3) {
                  // Fifth item (Block option)
                  return ListTile(
                    leading: Icon(Icons.block, color: Colors.blue),
                    title: Text("Block", style: TextStyle(color: Colors.black,fontSize: 12)),
                    onTap: () {
                      Get.to(()=>BlockSetting());
                    },
                  );
                } else if(index==4){
                  // Sixth item (Logout option)
                  return ListTile(
                    leading: SvgPicture.asset("assets/logout.svg"),
                    title: Text("Log Out", style: TextStyle(color: Colors.black,fontSize: 12)),
                    onTap: () {
                      // Show a dialog when the phone icon button is pressed
                      CustomDialog.showcustomDialog(context,"Are you sure you want to Log out","log out","Cancel");


                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}