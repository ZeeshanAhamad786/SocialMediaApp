import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controllers/GetuserdataDataController.dart';
import '../CreatePost/UploadFeed_Dialog.dart';
import 'CallHistory.dart';
import 'ChatRoomScreen.dart';

class MainChatScreens extends StatefulWidget {
  MainChatScreens({Key? key}) : super(key: key);

  @override
  State<MainChatScreens> createState() => _MainChatScreensState();
}

class _MainChatScreensState extends State<MainChatScreens>
    with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Map<String, dynamic> userMap = {};
  bool isloading = false;
  final TextEditingController _search = TextEditingController();
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection("users").doc(_auth.currentUser?.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //online
      setStatus("Online");
    } else {
      //offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  Future<void> onSearch() async {
    try {
      setState(() {
        isloading = true;
      });

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection("users")
          .where("email", isEqualTo: _search.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userMap = querySnapshot.docs[0].data() ?? {}; // Check for null
          isloading = false;
        });

        // Update status
        setStatus("Online");
        // Retrieve timestamp and add it to userMap
        Timestamp timestamp = userMap["time"] ?? Timestamp.now();
        String formattedTime = timestamp.toDate().toString();
        userMap["time"] = formattedTime;

        // Display message count as an integer
        int messageCount = userMap["messageCount"] ?? 0;
        print("UserMap: $userMap, Message Count: $messageCount");
      } else {
        setState(() {
          userMap = {}; // No matching user found
          isloading = false;
        });
        print("No user found");
      }
    } catch (e) {
      setState(() {
        userMap = {}; // Handle the error case
        isloading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          getUserDataController
                              .getUserDataRxModel.value?.profileimage ??
                              '',
                        ),
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
                                  spreadRadius: 1,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.to(const CallHistory());
                              },
                              child: const Text(
                                "Calls",
                                style: TextStyle(color: Color(0xffAC83F6)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: isloading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          // SizedBox(
          //   height: size.height / 20,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onTap: () {
                // onSearch();
              },
              controller: _search,
              decoration: InputDecoration(isDense: true,
                prefixIcon: Transform.scale(
                    scale: 0.6, child: const Icon(Icons.search_outlined)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5))),
                hintText: "Search",hintStyle: const TextStyle(fontSize: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: onSearch,
            child: const Text(
              "Search",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: size.height / 20),
          userMap != null
              ? ListTile(
              onTap: () {
                if (userMap != null &&
                    userMap["name"] != null &&
                    userMap["email"] != null) {
                  String roomId = chatRoomId(
                    getUserDataController
                        .getUserDataRxModel.value!.name,
                    userMap["name"] ?? "N/A",
                  );

                  log(roomId);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatRoom(
                        chatRoomId: roomId,
                        userMap: userMap,
                      ),
                    ),
                  );
                } else {
                  // Handle the case where required fields are missing or null
                  print("User data is incomplete");
                }
              },
              leading: CircleAvatar(
                backgroundImage:
                NetworkImage(userMap["photoUrl"] ?? ""),
              ),
              title: Text(
                userMap["name"] ?? "N/A",
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                userMap["email"] ?? "N/A",
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Column(
                children: [
                  Text(
                    userMap["time"]  ??  "N/A", style: const TextStyle(color: Colors.black),
                  ),
                  CircleAvatar(
                    radius: 14,
                    child: Text(userMap["messageCount"]?.toString() ?? ""),
                  ),
                ],
              )
          )
              : Container(),

        ],
      ),
    ));
  }
}