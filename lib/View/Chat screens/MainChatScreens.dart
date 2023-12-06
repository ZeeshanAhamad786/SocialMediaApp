
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controllers/GetuserdataDataController.dart';

import '../CreatePost/UploadFeed_Dialog.dart';
import 'CallHistory.dart';

class MainChatScreens extends StatefulWidget {
  const MainChatScreens({super.key});

  @override
  State<MainChatScreens> createState() => _MainChatScreensState();
}

class _MainChatScreensState extends State<MainChatScreens> {
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  // Declare a variable to hold the active chat user list
  List<String> activeChatUsersList = [];
  List<dynamic> activeChatUsersData = [];
  var isLoading = false.obs;

// Your method to fetch the active chat user list
  Future<List<String>> fetchActiveChatUserList() async {
    try {
      isLoading.value = true;
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

      // log("documentSnapshot =${documentSnapshot.data()}");

      if (documentSnapshot.exists) {
        // Retrieve the activeChatUser field from the document
        activeChatUsersList =
            List<String>.from(documentSnapshot.data()?["activeChatUser"] ?? []);

        DocumentSnapshot<Map<String, dynamic>>? document;

        List.generate(
          activeChatUsersList.length,
          (index) async {
            document = await FirebaseFirestore.instance
                .collection("users")
                .doc(activeChatUsersList[index])
                .get();

            if (document!.exists) {
              activeChatUsersData.add(documentSnapshot.data());
            }
          },
        );

        isLoading.value = false;

        return activeChatUsersList;
      }
    } catch (e) {
      print("Error fetching active chat user list: $e");
    }

    // Return an empty list if there was an error or the document doesn't exist
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchActiveChatUserList();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Obx(
        () =>       isLoading.value? const Center(child: CircularProgressIndicator()):
          Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(92.0),
                // here the desired height
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 8),
                          child: Row(
                            children: [
                              Obx(
                                () {
                                  return CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      getUserDataController.getUserDataRxModel
                                              .value?.profileimage ??
                                          '',
                                    ),
                                  );
                                },
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
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1)
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(const CallHistory());
                                      },
                                      child: const Text("Calls",
                                          style: TextStyle(
                                              color: Color(0xffAC83F6))),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Search ",
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 10),
                                contentPadding: const EdgeInsets.all(8),
                                prefixIcon: Transform.scale(
                                  scale: 0.6,
                                  child: const Icon(Icons.search_outlined),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            body: Stack(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: activeChatUsersList.length,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      leading:CircleAvatar() ,
                    );
                  },
                )),
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
            )),
      ),
    );
  }
}
