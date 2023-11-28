import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:get/get_core/src/get_main.dart';

class CustomDialog {
  static void showcustomDialog(BuildContext context,String heading,String button1, String button2) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25
                 ), // Set circular border radius here
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                heading,
                style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w500),textAlign: TextAlign.center,
              ),
            ),
            content:               Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      // Perform logout actions here
                      // Get.back(); // Close the dialog
                    },
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.5,
                          ),
                        ],
                        color: button1=="Hide" || button1=="Unfollow"  ? Color(0xffAC83F6): Color(0xffFF4B4B),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          button1,
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.5,
                          ),
                        ],
                        color: button1=="Hide" || button1=="Unfollow" ?  Colors.white : Color(0xffAC83F6) ,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          button2,
                          style: TextStyle(color: button1=="Hide" || button1=="Unfollow"  ? Color(0xffAC83F6): Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),


          ),
        );
      },
    );
  }
}
