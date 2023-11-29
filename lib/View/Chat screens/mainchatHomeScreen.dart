import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth if not imported
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatRoomScreen.dart';

class MainChatHomeScreen extends StatefulWidget {
  const MainChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainChatHomeScreen> createState() => _MainChatHomeScreenState();
}

class _MainChatHomeScreenState extends State<MainChatHomeScreen>  with WidgetsBindingObserver{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  late Map<String, dynamic> userMap = {};
  bool isloading = false;
  final TextEditingController _search = TextEditingController();
  @override
  void initState (){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }
  void setStatus(String status) async{
    await _firestore.collection("users").doc(_auth.currentUser?.uid).update({
      "status":status,
    });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state ==AppLifecycleState.resumed){
//online
      setStatus("Online");
    }else {
      //offline
      setStatus("Offine");
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
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isloading = true;
    });

    await _firestore
        .collection("users")
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs.isNotEmpty
            ? value.docs[0].data()
            : {}; // Update userMap or set it to an empty map if there are no results
        isloading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("HELLO"),
      ),
      body: isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Center(
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: onSearch,
            child: Text(
              "Search",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: size.height / 20),
          userMap !=null
              ? ListTile(
            onTap: () {
              String roomId = chatRoomId(
                  _auth.currentUser!.displayName ?? "N/A",
                  userMap["name"] ?? "N/A");

              log(userMap["name"].toString() + _auth.currentUser!.displayName.toString());

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatRoom(
                      chatRoomId: roomId,
                      userMap: userMap,
                    )),
              );
            },
            leading: Icon(Icons.account_box, color: Colors.black),
            title: Text(userMap["name"] ?? "N/A",
                style: TextStyle(color: Colors.black)),
            subtitle: Text(userMap["email"] ?? "N/A",
                style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.chat, color: Colors.black),
          )
              : Container()
        ],
      ),
      floatingActionButton:FloatingActionButton(
        child:  Icon(Icons.group),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (_)=>GroupChatMainChatHomeScreen()));
        },
      ) ,
    );
  }
}
