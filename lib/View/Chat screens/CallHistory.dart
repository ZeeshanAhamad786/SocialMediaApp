import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CallHistory extends StatefulWidget {
  const CallHistory({Key? key}) : super(key: key);

  @override
  State<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  List<String> chatHistory = [
    "Minha Anjum",
    "Zarish",
    "sehrish",
  ];
  List<String> time = [
    "54 min,10 min ago",
    "50 min,5 min ago",
    "30 min,4 min ago",
  ];
  List<String> imges = [
    "assets/h1.jpg",
    "assets/h2.jpg",
    "assets/h3.jpg",
  ]; // // List to store chat history items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: Get.height*0.09,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  Text(
                    "Call history",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    chatHistory[index],
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  subtitle: Text(
                    time[index],
                    style: TextStyle(color: Color(0xffD8D8D8), fontSize: 10),
                  ),
                  leading:
                  Container(
                    height: Get.height*0.10,
                    width: Get.width*0.10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffAC83F6)),
                        image: DecorationImage(
                            image: AssetImage(imges[index]),fit: BoxFit.cover
                            )),
                  ),
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: SvgPicture.asset("assets/phonebold.svg"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
