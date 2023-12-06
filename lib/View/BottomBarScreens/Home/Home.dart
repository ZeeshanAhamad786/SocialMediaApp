import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Components/BottomNavigationBar/BotttomBar_Widget.dart';
import '../../../Components/Drawer/CustomDrawer.dart';
import '../../../Controllers/GetuserdataDataController.dart';
import '../../../Controllers/ProfileController.dart';
import '../../../Widgets/MyTabBar.dart';
import '../../../Widgets/PicPost_Widget.dart';
import '../../Chat screens/CallBalance.dart';
import '../../Chat screens/MainChatScreens.dart';
import '../../Chat screens/NotificationScreen.dart';
import '../../Chat screens/PhoneTab.dart';
import '../../Chat screens/mainchatHomeScreen.dart';
import '../../CreatePost/UploadFeed_Dialog.dart';
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  final ProfileController controller = Get.put(ProfileController());
  int _currentIndex = 0;
  bool isDrawerOpen = false;

  final List<Widget> _screens = [
    HomeScreenContent(
      scaffoldKey: _scaffoldKey,
    ),
    MainChatScreens(),
    const PhoneTab(),
  ];

  List<String> profileIcons = [
    "assets/Iconly-Bulk-Profile.svg",
    "assets/Bookmark.svg",
    "assets/Setting.svg",
    "assets/Bulk-Wallet.svg",
  ];

  List<String> names = [
    "View Profile",
    "Saved",
    "Setting and privacy",
    "Wallet"
  ];

  @override
  Widget build(BuildContext context) {
    if (getUserDataController.getUserDataRxModel.value == null) {
      getUserDataController.getUserData();
    }

    final userProfile = controller.userProfile.value;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      // bottomNavigationBar:  _currentIndex!=2 ? Padding(
      //   padding:  const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
      //   child: CustomBottomNavigationBar(currentIndex: _currentIndex, onTap: (int ) {   setState(() {
      //     _currentIndex = int;
      //   }); },),
      // ): SizedBox(),
      body: Stack(
        children: [
          _screens[_currentIndex],
          if (_currentIndex != 2)
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

class HomeScreenContent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomeScreenContent({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    GetUserDataController getUserDataController =
        Get.put(GetUserDataController());
    return Obx(
      () => getUserDataController.isGetUserDataLoading.value
          ? const CircularProgressIndicator()
          : Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            onPressed: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            icon: ProfilePicWidget(
                              picType: 'network',
                              getUserDataController
                                  .getUserDataRxModel.value!.profileimage,
                              30,
                              30,
                            ),
                          ),
                        ),
                        const Text(
                          'Explore',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: SvgPicture.asset('assets/search.svg',
                                  height: 18, width: 18, color: Colors.black),
                              onPressed: () {},
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(const NotificationScreen());
                              },
                              icon: SvgPicture.asset('assets/notification.svg',
                                  height: 18, width: 18, color: Colors.black),
                            )
                          ],
                        )
                      ],
                    ),
                    const Expanded(child: MyTabBar()),
                  ],
                ),
                Positioned(
                  bottom: 10.5.h,
                  right: 2.5.h,
                  child: FloatingActionButton(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.1))),
                    backgroundColor: const Color(0xffAC83F6),
                    foregroundColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return UploadFedd_Dialog();
                        },
                      );
                    },
                    child: Icon(Icons.add, size: 3.5.h),
                  ),
                ),
              ],
            ),
    );
  }
}
