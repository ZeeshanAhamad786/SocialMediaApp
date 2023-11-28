import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RecentCall extends StatefulWidget {
  const RecentCall({Key? key}) : super(key: key);

  @override
  State<RecentCall> createState() => _RecentCallState();
}

class _RecentCallState extends State<RecentCall> {
  List<String> chatHistory = [
    "Minha Anjum",
    "Zeeshan",
    "Adil",
  ];
  final List<String> title=[
    "Follwing",
    "1 new post",
    "Followed by Yasir ",

  ];
  final List<String> pictures=[
    "assets/h1.jpg",
    "assets/h2.jpg",
    "assets/h3.jpg",

  ];// Lis// List to store chat history items

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(
          height: Get.height*0.03,
        ),
        Row(
          children: [   IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios,
                color: Colors.black, size: 16),
          ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width/1.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 1)
                  ]),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search here",
                    hintStyle:
                    TextStyle(color: Color(0xffD8D8D8), fontSize: 12),
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: Transform.scale(
                      scale: 0.3,
                      child: SvgPicture.asset('assets/Bulk-Search.svg'),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ],
        ),
        SizedBox(height: Get.height*0.01,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
              Text("See all",style: TextStyle(color: Colors.grey.withOpacity(0.8)),)
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  chatHistory[index],
                  style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  title[index],
                  style: TextStyle(color: Color(0xff3EA7FF), fontSize: 10),
                ),
                leading:    Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffAC83F6)),
                      image: DecorationImage(
                          image: AssetImage(pictures[index]),
                          fit: BoxFit.cover)),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Icon(CupertinoIcons.multiply,color: Colors.grey.withOpacity(0.7)),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
