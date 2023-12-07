

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

import '../../Controllers/GetuserdataDataController.dart';
import '../CreatePost/UploadFeed_Dialog.dart';
import 'CallHistory.dart';
import 'ChatRoomScreen.dart';

class MainChatScreens extends StatefulWidget {

  const MainChatScreens({super.key, });


  @override
  State<MainChatScreens> createState() => _MainChatScreensState();
}

class _MainChatScreensState extends State<MainChatScreens> {
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
   bool otherUserProfile=false;

  // Declare a variable to hold the active chat user list
  List<String> activeChatUsersList = [];
  List<dynamic> activeChatUsersData = [];

  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Your method to fetch the active chat user list

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> fetchActiveChatUserData() async {
    try {
      isLoading.value = true;

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

      if (documentSnapshot.exists) {
        List<String> activeChatUsersList =
        List<String>.from(documentSnapshot.data()?["activeChatUser"] ?? []);

        List<DocumentSnapshot<Map<String, dynamic>>> activeChatUsersData = [];

        for (int index = 0; index < activeChatUsersList.length; index++) {
          DocumentSnapshot<Map<String, dynamic>> document = await _firestore
              .collection("users")
              .doc(activeChatUsersList[index])
              .get();

          if (document.exists) {
            activeChatUsersData.add(document);
          }
        }

        isLoading.value = false;

        // Return only the list of user data

        return activeChatUsersData;
      }
    } catch (e) {
      isLoading.value = false;
    }

    // Return an empty list if there was an error or the document doesn't exist
    return [];
  }

  String chatRoomId1 =const Uuid().v1();


  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
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
            FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                future: fetchActiveChatUserData(),
            builder: (context, snapshot) {
           if (snapshot.hasError) {
                // If there was an error, display an error message
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // If there is no data, display a message
                return const Center(child:Text(" No Chat Availible"));
              } else {
                // If data is available, build the ListView
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var userData = snapshot.data![index].data();

                    // Customize the widget to display user data
                    return InkWell(onTap:  () {
                     // Generate a UUID if otherUserProfile is false

                      Get.to(() => ChatRoom(
                        chatRoomId: chatRoomId(
                          getUserDataController.getUserDataRxModel.value!.name,
                          userData?['name'],
                        ),
                        userMap: {
                          "name": userData?['name'],
                          "photoUrl": userData?['photoUrl'],
                        },
                        userId: userData?['userId'], profileName: userData?['name'],profilrImage: userData?['photoUrl'],
                      ));





                      // Get.to(() =>  (chatRoomId: chatRoomId1,
                      // userMap: {
                      //   "name": userData?['name'] ?? 'No username',
                      //   "photoUrl":userData?['photoUrl'] ?? 'No username',
                      // } , userId:userData?['userId'] ?? 'No username' , profileName: userData?['name'] ?? 'No username',
                      // profilrImage: userData?['photoUrl'] ?? 'No username'),);
                    }
                    ,
                      child: ListTile(leading: CircleAvatar(radius: 25,
                        backgroundImage: NetworkImage(userData?['photoUrl'] ?? ''),),
                        title: Text(userData?['name'] ?? '',style: const TextStyle(fontSize: 16),),subtitle:
                          userData!['lastMessage'].toString().length<10?   Text(userData?['lastMessage'] ?? '' ,style: TextStyle(fontSize: 12)
                          // Add more ListTile properties as needed
                        ):Text("${userData?['lastMessage']?.substring(0, 8)}.....",style: const TextStyle(fontSize: 12)
                            // Add more ListTile properties as needed
                          ),trailing: Text(userData?['lastMessageTime']??"" ),)
                    );
                  },
                );
              }
            },
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
            )),
      ),
    );
  }
}
