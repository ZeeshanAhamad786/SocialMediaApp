import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/SharePost_Model.dart';
import 'CustomButton.dart';
import 'PicPost_Widget.dart';

class SharePost_Widget extends StatefulWidget {
  SharePost_Model sharepost;
  SharePost_Widget({Key? key,required this.sharepost}) : super(key: key);

  @override
  State<SharePost_Widget> createState() => _SharePost_WidgetState();
}

class _SharePost_WidgetState extends State<SharePost_Widget> {
  bool option1 = false;
  List<String> fetchFollowersIdList = [];
  List<dynamic> fetchFollowersData = [];

  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Your method to fetch the active chat user list

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> fetchFollowersIdData() async {
    try {
      isLoading.value = true;

      // Get the document for the current user
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

      if (documentSnapshot.exists) {
        // Get the list of follower user IDs
        List<String> fetchFollowersIdList =
        List<String>.from(documentSnapshot.data()?["followersId"] ?? []);

        List<DocumentSnapshot<Map<String, dynamic>>> fetchFollowersData = [];

        // Fetch data for each follower, excluding the current user
        for (int index = 0; index < fetchFollowersIdList.length; index++) {
          String followerId = fetchFollowersIdList[index];

          // Exclude the current user
          if (followerId != FirebaseAuth.instance.currentUser!.uid) {
            // Use a query to get data for each follower
            QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await _firestore.collection("users").where("userId", isEqualTo: followerId).get();

            if (querySnapshot.docs.isNotEmpty) {
              fetchFollowersData.add(querySnapshot.docs.first);
            }
          }
        }

        isLoading.value = false;

        // Log and return the list of user data
        log("Followers ids are: $fetchFollowersData");

        return fetchFollowersData;
      }
    } catch (e) {
      isLoading.value = false;
      // Handle errors here
    }

    // Return an empty list if there was an error or the document doesn't exist
    return [];
  }

  @override
  void initState() {
    fetchFollowersIdData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 50,
    //   child: Row(
    //     children: [
    //       ProfilePicWidget(widget.sharepost.image, 45, 45),
    //       SizedBox(
    //         width: 10,
    //       ),
    //       Text(
    //         widget.sharepost.name,
    //         style: TextStyle(),
    //       ),
    //       Expanded(
    //         child: Align(
    //           alignment: Alignment.centerRight,
    //           child: CircularCheckBox(
    //             value: widget.sharepost.wantSend,
    //             onChanged: (newValue) {
    //               setState(() {
    //                 widget.sharepost.wantSend = newValue!;
    //               });
    //             },
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
      future: fetchFollowersIdData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, display a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there was an error, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there is no data, display a message
          return Center(child: Text('No followers available.'));
        } else {
          // If data is available, build the ListView
          return Container(height: 400,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var userData = snapshot.data![index].data();

                // Customize the widget to display user data
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userData?['photoUrl'] ?? ''),
                  ),
                  title: Text(userData?['name'] ?? ''),
                  // subtitle: Text(userData?['userId'] ?? ''),
                  trailing:CircularCheckBox(value: true, onChanged: (bool? value) {

                  },) ,
                  // Add more ListTile properties as needed
                );
              },
            ),
          );
        }
      },
    );
  }
}



class CircularCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CircularCheckBox({
    required this.value,
    required this.onChanged,
  });

  @override
  State<CircularCheckBox> createState() => _CircularCheckBoxState();
}

class _CircularCheckBoxState extends State<CircularCheckBox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChanged(isChecked);
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked ? Colors.blue : Colors.white,
          border: Border.all(
            width: 2.0,
            color: isChecked ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}


Widget YeswanttoSend_Widget(){
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.5,
                    color: Colors.grey.withOpacity(0.3)
                )
              ]
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Write message here....',
              hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
              contentPadding: EdgeInsets.only(bottom: 12.0,left: 15),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: CustomButton(text: 'Send', onPressed: () {  },),
        ),
        SizedBox(height: 10,)
      ],
    ),
  );
}
