import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:socialmediaapp/View/Chat%20screens/CallHistory.dart';
import 'package:uuid/uuid.dart';


import '../../Controllers/GetuserdataDataController.dart';


class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;
  final String userId;
  final String profileName;
  final String profilrImage;

  ChatRoom(
      {super.key, required this.chatRoomId,
      required this.userMap,
      required this.userId,
      required this.profileName,
      required this.profilrImage});


  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with WidgetsBindingObserver {

  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _status = "Offline";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }
  void setStatus(String status) async {
    await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
      "status": status,

    });
    setState(() {
      _status = status;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //online
      setStatus("Online");
    } else {
      //offline
      setStatus("Offine");
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
  void onSendMessage() async {
    String messageText = _message.text;
    if (messageText.isNotEmpty) {
      String currentUserID = _auth.currentUser!.uid;

      Map<String, dynamic> messageData = {
        "sendBy": currentUserID,
        "receiveBy": widget.userId,
        "message": messageText,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      // Add the message to the chats collection
      DocumentReference messageRef = await _firestore
          .collection("chatRoom")
          .doc(widget.chatRoomId)
          .collection("chats")
          .add(messageData);
      _message.clear();
      // Get a unique set of user IDs from the users in the chat room
      Set<String> uniqueUserIds = {currentUserID, widget.userId};

      // Convert the set to a list
      List<String> allUserIds = uniqueUserIds.toList();

      // Iterate through each user in the chat room
      for (String userId in allUserIds) {
        // Fetch existing chat rooms for the user
        DocumentSnapshot userSnapshot =
        await _firestore.collection("users").doc(userId).get();

        if (userSnapshot.exists) {
          // Get current list of chat rooms or create an empty list
          List<String> userChatRooms =
          List<String>.from(userSnapshot["chatRooms"] ?? []);

          // Add the new chat room ID
          userChatRooms.add(widget.chatRoomId);

          // Update the user document with the new list of chat rooms
          await _firestore.collection("users").doc(userId).update({
            "chatRooms": userChatRooms,
          });
        } else {
          // Handle the case where the document doesn't exist
          log("User document does not exist for ID: $userId");
        }
      }

      // Log the list of users
      log("All users in the chat room: $allUserIds");

      _message.clear();
    } else {
      log("Enter some text");
    }
  }


  Future<void> updateActiveChatListInFirestore(String activeChatUser) async {
    try {
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "activeChatUser": FieldValue.arrayUnion([activeChatUser])
      });
    } catch (e) {
      print("Error updating active chat user list: $e");
    }
  }

  Future<void> updateOtherActiveChatListInFirestore(
      String activeChatUser) async {
    try {
      await _firestore.collection("users").doc(activeChatUser).update({
        "activeChatUser":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
    } catch (e) {
      print("Error updating active chat user list: $e");
    }
  }

  Future<List<String>> fetchActiveChatUserList() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        // Retrieve the activeChatUser field from the document
        List<String> activeChatUserList =
            List<String>.from(documentSnapshot.data()?["activeChatUser"] ?? []);
        log("Active Chat List is =${activeChatUserList.length}");
        return activeChatUserList;
      }
    } catch (e) {
      print("Error fetching active chat user list: $e");
    }

    // Return an empty list if there was an error or the document doesn't exist
    return [];
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((xFile) => {
          if (xFile != null)
            {imageFile = File(xFile.path), uploadImage(imageFile)}
        });
  }

  Future uploadImage(image) async {
    String fileName = const Uuid().v1();
    int status = 1;

    await _firestore
        .collection("chatRoom")
        .doc(widget.chatRoomId)
        .collection("chats")
        .doc(fileName)
        .set({
      "sendBy": _auth.currentUser!.uid,
      "receiver": widget.userId,
      "message": "",
      "time": FieldValue.serverTimestamp(),
    });

    //
    var ref =
        FirebaseStorage.instance.ref().child("images").child("$fileName.jpg");

    var uploadTask = await ref.putFile(image).catchError((error) async {
      await _firestore
          .collection("chatRoom")
          .doc(widget.chatRoomId)
          .collection("chats")
          .doc(fileName)
          .delete();
      status = 0;
    });
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await _firestore
          .collection("chatRoom")
          .doc(widget.chatRoomId)
          .collection("chats")
          .doc(fileName)
          .update({"message": imageUrl});

      log(imageUrl.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
          ),
          child: Transform.translate(
            offset: const Offset(0, 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 1.h,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.profilrImage),
                ),
                SizedBox(width: 1.5.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.5.h),
                    Text(
                      widget.profileName,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "$_status ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 8),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle phone icon tap
                        // Add your phone functionality here
                      },
                      icon: Transform.scale(
                        scale: 0.7,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CallHistory()),
                            );
                          },
                          icon: const Icon(Icons.call, color: Colors.blue),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle video icon tap
                        // Add your video functionality here
                      },
                      icon: const Icon(Icons.videocam_rounded,
                          color: Colors.blue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection("chatRoom")
                .doc(widget.chatRoomId)
                .collection("chats")
                .orderBy("time", descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> map = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return messages(size, map, context);
                  },
                );
              } else if (snapshot.hasError) {
                // Handle error
                return Text("Error: ${snapshot.error}");
              } else {
                // Handle loading state
                return const CircularProgressIndicator();
              }
            },
          )),
          Container(
            height: size.height / 10,
            width: size.width,
            alignment: Alignment.center,
            child: SizedBox(
              height: size.height / 12,
              width: size.width / 1.1,
              child: Row(children: [
                SizedBox(
                  height: size.height / 17,
                  width: size.width / 1.1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1)
                      ],
                    ),
                    child: TextField(
                      controller: _message,
                      // Allow the TextField to expand vertically
                      decoration: InputDecoration(
                        hintText: "Type your message",
                        hintStyle: const TextStyle(fontSize: 12),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Ensure buttons take minimum space
                          children: [
                            // IconButton(
                            //   icon: Icon(Icons.image),
                            //   onPressed: () => getImage(),
                            // ),
                            InkWell(
                                onTap: () => getImage(),
                                child: const Icon(Icons.image)),
                            SizedBox(
                              width: 2.h,
                            ),
                            SvgPicture.asset("assets/Bold-Voice 2.svg"),
                            IconButton(
                              onPressed: onSendMessage,
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map["type"] == "text"
        ? Container(
            width: size.width,
            alignment: map["sendBy"] == _auth.currentUser?.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: Text(map["message"],
                  style: const TextStyle(color: Colors.white)),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map["sendBy"] == _auth.currentUser?.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ShowImage(
                        imageURL: map["message"],
                      ))),
              child: Container(
                  height: size.height / 2.5,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  alignment: map["message"] != "" ? null : Alignment.center,
                  child: map["message"] != ""
                      ? Image.network(
                          map["message"],
                          fit: BoxFit.cover,
                        )
                      : const CircularProgressIndicator()),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageURL;

  const ShowImage({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Image.network(imageURL),
      ),
    );
  }
}
