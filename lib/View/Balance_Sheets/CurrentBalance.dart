import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'Payment Method.dart';

class CurrentBalance extends StatefulWidget {
  const CurrentBalance({Key? key}) : super(key: key);

  @override
  State<CurrentBalance> createState() => _CurrentBalanceState();
}

class _CurrentBalanceState extends State<CurrentBalance> {
  // Function to generate ListTile
  Widget buildListTile(String title, String subtitle, String trailingText) {
    return ListTile(
      leading: Transform.scale(
          scale: 0.6,
          child: SvgPicture.asset("assets/upgrade-update-icon.svg")),
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 12)),
      subtitle:
          Text(subtitle, style: TextStyle(color: Colors.black, fontSize: 12)),
      trailing: Text(trailingText,
          style: TextStyle(color: Colors.black, fontSize: 12)),
    );
  }

  int _currentIndex = 0; // Declare and initialize _currentIndex
  void _showTopUpOptionsDialog(BuildContext context) {
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
            title: Center(
                child: Text('Select Your Top-Up Option',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey
                      ),
                      
                    ],
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Handle the first button press
                      Navigator.pop(context);
                      Get.to(PaymentMethod());
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('10 minutes',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        Text(
                          "\$ 10",
                          style: TextStyle(color: Color(0xff3EA7FF)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.grey
                        ),

                      ],
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Handle the first button press
                      Navigator.pop(context); // Close the dialog
                      Get.to(PaymentMethod());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('30 minutes',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        Text(
                          "\$ 30",
                          style: TextStyle(color: Color(0xff3EA7FF)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.grey
                        ),

                      ],
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Handle the first button press
                      Navigator.pop(context); // Close the dialog
                      Get.to(PaymentMethod());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('60 minutes',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        Text(
                          "\$ 60",
                          style: TextStyle(color: Color(0xff3EA7FF)),
                        )
                      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.left_chevron,
                      size: 16,
                    )),
                Text(
                  "Wallet",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Minutes left for International calls",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  Text(
                    "78.6 min",
                    style: TextStyle(
                        color: Color(0xffAC83F6), fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextButton(
                onPressed: () {
                  _showTopUpOptionsDialog(context);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5,
                      ),
                    ],
                    color: Color(0xffAC83F6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "   Top Up",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        IconButton(
                            onPressed: () {
                              // Get.to(()=>TopUpOption());
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 14,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Recent Top ups",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xffD8D8D8),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("This Week",
                        style:
                            TextStyle(color: Color(0xffD8D8D8), fontSize: 12)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xffD8D8D8),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            buildListTile('Top Up', '04-15-2023', '\$2154'),
            SizedBox(height: 5),
            buildListTile('Top Up', '04-15-2023', '\$2154'),
            SizedBox(height: 5),
            buildListTile('Top Up', '04-15-2023', '\$2154'),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xffD8D8D8),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("This Month",
                        style:
                            TextStyle(color: Color(0xffD8D8D8), fontSize: 12)),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xffD8D8D8),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            buildListTile('Top Up', '04-15-2023', '\$2154'),
            SizedBox(height: 5),
            buildListTile('Top Up', '04-15-2023', '\$2154'),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
