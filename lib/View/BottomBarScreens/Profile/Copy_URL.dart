import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CopyURLDialog extends StatefulWidget {
  @override
  State<CopyURLDialog> createState() => _CopyURLDialogState();
}

class _CopyURLDialogState extends State<CopyURLDialog> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.text = "https://www.examplefakelink.com/spe";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Copy URL",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: Get.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3), spreadRadius: 1)
                      ],
                      color: Colors.white),
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("https://www.examplefakelink.com/spe",style: TextStyle(color: Color(0XFFBBBBBB),fontSize: 10)),
                      SizedBox(width: 15,),
                      InkWell(onTap: () {
                        Navigator.pop(context);
                      },
                          child: SvgPicture.asset("assets/copy-link-icon.svg")),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

void showCopyURLDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          // Previous screen content goes here
          // Add your original content/widgets here

          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.grey.withOpacity(0.5), // Adjust opacity as needed
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),

          // Copy URL dialog
          Center(
            child: CopyURLDialog(),
          ),
        ],
      );
    },
  );
}
