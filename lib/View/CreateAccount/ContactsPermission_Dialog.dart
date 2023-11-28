import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/View/Login_Screens/Log_In.dart';
import 'package:socialmediaapp/View/Login_Screens/Sign_In.dart';

import '../../../Controllers/OtherUser_MoreButtonContoller.dart';
import '../../Widgets/CustomButton.dart';

class ContactsPermission_Dialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ForUserProfile(context);
  }

  Widget ForUserProfile(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.3, // Adjust the height as needed
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            height: 3,
            width: 70,
            color: Color(0xff707070),
          ),
          SizedBox(height: 20,),
          SvgPicture.asset(
            'assets/PROFIL.svg',
            color: Colors.blue,
            height: 20,
            width: 20,
          ),
          SizedBox(height: 20,),
          Text('Allow to access your Contact ?'),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15),
            child: CustomButton(
              text: 'Allow',
              onPressed: () {
                Get.to(LogIn());
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15),
            child: CustomButton(
              text: 'Do not Allow',
              onPressed: () {
                Navigator.pop(
                  context
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
