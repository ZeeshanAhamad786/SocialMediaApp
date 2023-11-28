import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Balance_Sheets/Payment Method.dart';
import '../Settings/Setting_Privacy.dart';
import 'CallHistory.dart';

class CallBalance extends StatefulWidget {
  const CallBalance({Key? key}) : super(key: key);

  @override
  State<CallBalance> createState() => _CallBalanceState();
}

class _CallBalanceState extends State<CallBalance> {
  List<String> chatHistory = [
    "Minha Anjum",
    "Farhan Arif",
    "Aniqa Sulman",
    "Farhan Arif",
    "Aniqa Sulman",
    "Aniqa Sulman",
  ]; // List to store chat history items
  List<String> profileImages = [
    "assets/model1.jpg",
    "assets/model2.jpg",
    "assets/model3.jpg",
    "assets/model4.jpg",
    "assets/h1.jpg",
    "assets/h3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 30),
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
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                Text(
                  "Call",
                  style: TextStyle(color: Colors.black),
                ),

                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CallHistory()),
                      );                  },
                    icon: SvgPicture.asset("assets/history-icon.svg")
                ),

              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(alignment: Alignment.topLeft,
                child: Text("Current Balance",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: Get.height*0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration( color: Color(0xff3EA7FF),
                  borderRadius: BorderRadius.circular(20)),

              child: ListTile(
                dense: true,
                title: Row(
                  children: [SvgPicture.asset("assets/increase-up-profit-icon.svg"),
                    SizedBox(width: Get.width*0.02,),
                    Text(
                      "2.71%",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                subtitle: Text(
                  '21,554.80\$',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: SvgPicture.asset(
                  "assets/flower.svg",
                  // fit: BoxFit.cover,
                  // width: 150,
                  // height: 150,
                ),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: () {
                // Get.to(()=>PaymentMethod());
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.4,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.5,
                    ),
                  ],
                  color: Color(0xffAC83F6),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "      Top Up",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      IconButton(onPressed: () {
                        // Get.to(()=>PaymentMethod());
                      }, icon: Image.asset("assets/Arrow - Right.png")),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Make Calls",style: TextStyle( color: Colors.black,fontWeight: FontWeight.w400)),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    chatHistory[index],
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  leading:  Container(
                    height: Get.height*0.10,
                    width: Get.width*0.10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffAC83F6)),
                        image: DecorationImage(
                            image: AssetImage(profileImages[index]),fit: BoxFit.cover
                        )),
                  ), // Use the corresponding profile image for each chat item
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: SvgPicture.asset("assets/phonebold.svg"),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),

    );
  }
}