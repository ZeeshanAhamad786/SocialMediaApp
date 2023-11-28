import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockSetting extends StatefulWidget {
  @override
  State<BlockSetting> createState() => _BlockSettingState();
}

class _BlockSettingState extends State<BlockSetting> {
  final Map<String, String> nameToImage = {
    'Alishba': 'assets/profile1.png',
    'Maryam': 'assets/profile2.png',
  };
  final List<String> names = ['Alishba', 'Maryam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: names.length + 1, // Add 1 for the header
        itemBuilder: (context, index) {
          if (index == 0) {
            // Header item
            return Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 14,
                        ),
                      ),
                      Text(
                        "Block",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 40,width: 40,)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
              ],
            );
          } else {
            // List items with names
            String name = names[index - 1];
            String profileImage = nameToImage[name] ?? 'assets/default_profile.png';

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(profileImage),
              ),
              title: Text(name, style: TextStyle(color: Colors.black, fontSize: 12)),
              trailing: TextButton(
                onPressed: () {
                  // Handle unblock logic here
                  Get.back();
                },
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      " Unblock",
                      style: TextStyle(color: Color(0xffAC83F6), fontSize: 11),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
