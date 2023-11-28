import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'DialCall_Widget.dart';
import 'RecentCall.dart';

class PhoneTab extends StatefulWidget {
  const PhoneTab({Key? key}) : super(key: key);

  @override
  State<PhoneTab> createState() => _PhoneTabState();
}

class _PhoneTabState extends State<PhoneTab> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:  Container(
        height: 35,
        child: TabBar(
          labelColor: Colors.black,

          controller: _tabController,
          labelStyle: TextStyle(fontSize: 13),
          indicatorColor: Color(0xffAC83F6),
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: 'KeyPad'), // First tab
            Tab(text: 'Recents'), // Second tab
            Tab(text: 'Contact'), // Second tab

          ],
        ),
      ),      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            DialCall_Widget(),
            RecentCall(),            Center(child: Text("Contacts"),),
          ],
        ),
      ),
    );
  }
}
