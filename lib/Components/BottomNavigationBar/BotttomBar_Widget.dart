import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height*0.07, // Set your desired height here
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.2.h),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.5,
          ),
        ],
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3.2.h),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xffAC83F6),
          selectedLabelStyle: const TextStyle(fontSize: 0),
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            _buildNavItem("assets/home.svg", currentIndex, 0),
            _buildNavItem("assets/Chat.svg", currentIndex, 1),
            _buildNavItem("assets/callto.svg", currentIndex, 2),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, int currentIndex, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        height: 4.5.h,
        width: 4.5.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? const Color(0xffAC83F6).withOpacity(0.3) : null,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            color: currentIndex == index ? const Color(0xffAC83F6) : null,
            width: 2.5.h,
            height: 2.5.h,
          ),
        ),
      ),
      label: '',
    );
  }
}