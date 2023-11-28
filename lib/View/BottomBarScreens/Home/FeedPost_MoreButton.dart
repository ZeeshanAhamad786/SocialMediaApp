import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import GetX package

import '../../../Controllers/FeedPost_MoreButtonController.dart';


class FeedPost_MoreButton extends StatelessWidget {
  final List<String> icons = [
    'assets/share.svg',
    'assets/save_blue.svg',
    'assets/unfollow.svg',
    'assets/hide.svg',
    'assets/report.svg',
    // Add more items as needed
  ];

  final List<String> texts = [
    'Share this post',
    'Save to watch later',
    'Unfollow',
    'Hide Post',
    'Report Post',
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Use GetBuilder to update the widget when needed
    return GetBuilder<FeedPost_MoreButtonController>(
      init: FeedPost_MoreButtonController(),
      builder: (controller) {
        return Container(
          height: 55 * icons.length.toDouble(), // Adjust the height as needed
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 5,),
              Container(
                height: 3,
                width: 90,
                color: Color(0xff707070),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Container(
                        height: 30,
                        child: ListTile(
                          leading: SvgPicture.asset(icons[index],),
                          title: Text(texts[index], style: TextStyle(fontSize: 14),),
                          onTap: () {
                            // Handle tap actions here
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
        );
      },
    );
  }
}

