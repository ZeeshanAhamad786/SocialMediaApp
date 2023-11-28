import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapp/View/BottomBarScreens/Home/PostsFeedScreen.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key? key}) : super(key: key);

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            padding: EdgeInsets.zero,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 14),
            indicatorColor: Color(0xffAC83F6),
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'News Feed'), // First tab
              Tab(text: 'Friends Feed'), // Second tab
            ],
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height*0.6,
            child: TabBarView(
              children: [
                // Content for Tab 1
                PostFeedScreen(saved_posts_Screen: false, ispersonalpost: false,),

                // Content for Tab 2
                PostFeedScreen(saved_posts_Screen: false, ispersonalpost: false,)

              ],
            ),
          ),

        ],
      ),
    );
  }
}
