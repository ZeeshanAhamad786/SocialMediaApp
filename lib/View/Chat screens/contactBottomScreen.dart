import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Components/BottomNavigationBar/MyBottomNavigationBar.dart';
import '../../Widgets/CustomButton.dart';

class contactBottomList extends StatefulWidget {
  const contactBottomList({Key? key}) : super(key: key);

  @override
  State<contactBottomList> createState() => _contactBottomListState();
}

class _contactBottomListState extends State<contactBottomList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Divider(
              color: Colors.black,thickness: 1,
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          Center(child: SvgPicture.asset("assets/Iconly-Bulk-Profile.svg",)),
          SizedBox(
            height: size.height / 50,
          ),
          Text("Allow to access your Contact ?",style: TextStyle(color: Colors.black,fontSize: 12)),
          SizedBox(
            height: size.height / 15,
          ),
          Text(
            "Allow",
            style: TextStyle(color: Color(0xffAC83F6)),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          CustomButton(
            text: "Don't Allow", onPressed: () {
            Get.offAll(() => BottomNavBarV2());
          }


          ),
        ]),
      ),
    );
  }
}
