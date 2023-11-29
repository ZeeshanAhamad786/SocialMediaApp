import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  ChatRoom({required this.chatRoomId, required this.userMap});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      "sendBy": getUserDataController.getUserDataRxModel.value!.name,
      "message": "",
      "type": "img",
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

  void onSendMessage() async {
    String messageText = _message.text;
    if (messageText.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendBy": getUserDataController.getUserDataRxModel.value!.name,
        "message": messageText,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await _firestore
          .collection("chatRoom")
          .doc(widget.chatRoomId)
          .collection("chats")
          .add(messages);
    } else {
      log("Enter some text");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(widget.userMap["photoUrl"] ?? ""),
    );
    super.initState();
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
          child: Transform.translate(offset: const Offset(0,12),
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
                SizedBox(width: 1.h,),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.userMap["photoUrl"] ?? ""),
                ),
                SizedBox(width: 1.5.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.5.h),
                    Text(
                      widget.userMap["name"] ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      widget.userMap["status"] ?? "",
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
                        child:  IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CallHistory()),
                            );
                          },
                          icon: const Icon(Icons.call, color: Colors.blue),
                        ),),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle video icon tap
                        // Add your video functionality here
                      },
                      icon: const Icon(Icons.videocam_rounded, color: Colors.blue),
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
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      });
                } else {
                  return Container(); // Handle other states here, e.g., return an empty widget
                }
              },
            ),
          ),
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
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1)],
                    ),
                    child: TextField(
                      controller: _message,
                      // Allow the TextField to expand vertically
                      decoration: InputDecoration(

                        hintText: "Type your message",hintStyle: const TextStyle(fontSize: 12),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min, // Ensure buttons take minimum space
                          children: [
                            // IconButton(
                            //   icon: Icon(Icons.image),
                            //   onPressed: () => getImage(),
                            // ),
                            InkWell(onTap:()=>getImage(),
                                child: const Icon(Icons.image)),
                            SizedBox(width: 2.h,),
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
      alignment: map["sendBy"] == _auth.currentUser?.displayName
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
      alignment: map["sendBy"] == _auth.currentUser?.displayName
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