import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../View/BottomBarScreens/Home/Home.dart';
import '../../View/Chat screens/MainChatScreens.dart';
import '../../View/Chat screens/PhoneTab.dart';
import 'BotttomBar_Widget.dart';

class BottomNavBarV2 extends StatefulWidget {
  @override
  _StackedBottomNavigationBarState createState() =>
      _StackedBottomNavigationBarState();
}

class _StackedBottomNavigationBarState extends State<BottomNavBarV2> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Home(),
    MainChatScreens(),
    PhoneTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          if(_currentIndex==1)
          Positioned(
            left: 1.0.h,
            right: 1.0.h,
            bottom: 2.0.h,
            child: CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}