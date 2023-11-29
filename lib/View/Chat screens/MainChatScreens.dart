import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Controllers/GetuserdataDataController.dart';
import '../CreatePost/UploadFeed_Dialog.dart';
import 'CallHistory.dart';
import 'ChatRoomScreen.dart';


class MainChatScreens extends StatefulWidget {
  @override
  State<MainChatScreens> createState() => _MainChatScreensState();
}

class _MainChatScreensState extends State<MainChatScreens> {
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
  final List<Map<String, dynamic>> data = [
    {
      'image': 'assets/model2.jpg',
      'name': 'Anna Bella',
      'description': 'Great! Thank you soo much',
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/model2.jpg',
      'name': 'Zeeshan',
      'description': "Hey! Bro what's Going on",
      'time': '11:54 PM',
      'messages': '3',
    },
    {
      'image': 'assets/model3.jpg',
      'name': 'Zeeshan',
      'description': "Great! Thank you soo much",
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/h1.jpg',
      'name': 'Imran',
      'description': "Hey! Bro what's Going on",
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/h3.jpg',
      'name': 'Usman',
      'description': "Great! Thank you soo much",
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/model3.jpg',
      'name': 'Zeeshan',
      'description': "Great! Thank you soo much",
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/model3.jpg',
      'name': 'Zeeshan',
      'description': "Great! Thank you soo much",
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/h1.jpg',
      'name': 'Imran',
      'description': "Hey! Bro what's Going on",
      'time': '11:54 PM',
      'messages': '2',
    },
    {
      'image': 'assets/h1.jpg',
      'name': 'Imran',
      'description': "Hey! Bro what's Going on",
      'time': '11:54 PM',
      'messages': '2',
    },


  ];

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    final size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 40),
                  child: Row(
=======
    int zeeshan=999;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(92.0), // here the desired height
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(40),
                  // color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(color: Colors.grey, blurRadius: 1)
                  // ]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
>>>>>>> Stashed changes
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6,top: 8),
                        child: Row(
                          children: [CircleAvatar(
                            radius: 20,
                            backgroundImage:NetworkImage( getUserDataController
                                .getUserDataRxModel.value?.profileimage ??
                                '',),
                          ),

                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 35,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(CallHistory());
                                    },
                                    child: Text("Calls",
                                        style:
                                        TextStyle(color: Color(0xffAC83F6))),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4,),
                      Container(height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search ",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.6), fontSize: 10),
                              contentPadding: EdgeInsets.all(8),
                              prefixIcon: Transform.scale(scale: 0.6,
                                child: Icon(Icons.search_outlined
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
          ),
          body: Stack(
            children: [
              ListView.builder(
                itemCount: data.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  int messageCount = int.parse(data[index]['messages']);
                  print(data[index]['messages']);
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ChatRoom( chatRoomId: '', userMap: {},)),
                      // );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:AssetImage(data[index]["image"],),
                      ),
                      title: Text(data[index]['name'],
                          style:
                          TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold)),
                      subtitle: Text(data[index]['description'],
                          style: TextStyle(color: Colors.black, fontSize: 9)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(data[index]['time'],
                              style: TextStyle(
                                  color: Colors.black, fontSize: 9)),
                          SizedBox(
                            height: Get.height * 0.003,
                          ),
                          Container(
                              height: messageCount < zeeshan ? 20 : 23,
                              width: messageCount < zeeshan ? 20 : 23,
                              decoration: BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              child:


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (messageCount < zeeshan)
                                    Center(
                                      child: Text(data[index]['messages'],
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.white)),
                                    ),
                                  if (messageCount > 999) Text("999+",  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white))

                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10.5.h,
                right: 2.5.h,
                child: FloatingActionButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                  backgroundColor: const Color(0xffAC83F6),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UploadFedd_Dialog();
                      },
                    );            },
                  child:  Icon(Icons.add, size: 3.5.h),
                ),
              ),
            ],
          )
      ),
    ));
  }
}
