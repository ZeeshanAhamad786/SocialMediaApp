// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChatRoomScreenController extends GetxController{
//
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   RxList<String> usersInChatRoom = <String>[].obs;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _message = TextEditingController();
//
//
//   RxList<Map<String, dynamic>> chatMessages = <Map<String, dynamic>>[].obs;
//
//
//   onSendMessage(String chatRoomId, String userId) async {
//     String messageText = _message.text;
//
//     if (messageText.isNotEmpty) {
//       Map<String, dynamic> messages = {
//         "sendBy": _auth.currentUser!.uid,
//         "receiver": userId,
//         "message": messageText,
//         "type": "text",
//         "time": DateTime.now(),
//       };
//
//       // Get the current user ID
//       String currentUserID = _auth.currentUser!.uid;
//
//       // Check if the users are already in the chatList
//       if (!usersInChatRoom.contains(currentUserID)) {
//         usersInChatRoom.add(currentUserID);
//       }
//
//       if (!usersInChatRoom.contains(userId)) {
//         usersInChatRoom.add(userId);
//       }
//
//       _message.clear();
//
//       // Update the chatList in the chat room document
//       await _firestore
//           .collection("chatRoom")
//           .doc(chatRoomId)
//           .update({"users": usersInChatRoom});
//
//       // Add the message to the chats collection
//       await _firestore
//           .collection("chatRoom")
//           .doc(chatRoomId)
//           .collection("chats")
//           .add(messages);
//
//       log("usersInChatRoom:${usersInChatRoom.length}");
//     } else {
//       log("Enter some text");
//     }
//   }
//
// }