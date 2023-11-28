import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../Models/ProfileModels.dart';
import 'All_TAb.dart';
import '../Home/PostsFeedScreen.dart';

class Profile_TabBar extends StatelessWidget {
  ProfileModel userprofile;

  Profile_TabBar({Key? key, required this.userprofile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
        length: 3,
        child:NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // The flexible app bar with the tabs
            SliverAppBar(
              title: const Text('App Bar'),
              expandedHeight: 200,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              bottom: const TabBar(tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ]),
            )
          ],
          // The content of each tab
          body: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    'Tab 1 content $index',
                  ),
                ),
              ),
              ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    'Tab 2 content $index',
                  ),
                ),
              ),
            ],
          ),
        ),














        // Column(
        //   children: [
        //     TabBar(
        //       indicatorSize: TabBarIndicatorSize.tab,
        //       labelStyle: TextStyle(fontSize: 16),
        //       // indicatorSize: TabBarIndicatorSize.label,
        //
        //       indicatorColor: Color(0xffAC83F6),
        //       padding: EdgeInsets.symmetric(horizontal: 40),
        //       indicatorWeight: 3,
        //       tabs: [
        //         Tab(text: 'All'), // First tab
        //         Tab(text: 'Images'), // Second tab
        //         Tab(text: 'Videos'), // Second tab
        //       ],
        //     ),
        //     SingleChildScrollView(
        //       child: Container(
        //         height: 170 * 5,
        //         child: TabBarView(
        //           children: [
        //             // Content for Tab 1
        //             All_Tab(
        //               userprofile: userprofile,
        //             ),
        //
        //             // Content for Tab 2
        //             Center(child: Text('Images')),
        //             Center(child: Text('Vedios')),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
