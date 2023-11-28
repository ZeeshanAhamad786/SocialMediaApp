import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Components/BottomNavigationBar/MyBottomNavigationBar.dart';
import 'CallBalance.dart';
import 'MainChatScreens.dart';

class MyBottomNavigation_Chat extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigation_Chat> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    BottomNavBarV2(),
    MainChatScreens(),
    CallBalance(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: _currentIndex != 0
          ? Padding(
        padding: const EdgeInsets.only(bottom: 20.0,left: 10,right: 10),
        child: Container(
          height: 55, // Set your desired height here
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.5,
              ),
            ],
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Color(0xffAC83F6),
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset("assets/Home.png", color: _currentIndex == 0
                ? Color(0xffAC83F6)
                : null,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset("assets/Chat.svg",color: _currentIndex == 1
                      ? Color(0xffAC83F6)
                      : null),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/Bold-Call.svg",color: _currentIndex == 2
                      ? Color(0xffAC83F6)
                      : null),
                  label: '',
                ),
              ],
            ),
          ),
        )
        ,
      )
          : SizedBox(),
    );
  }
}






