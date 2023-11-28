import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PaymentMethodProcess extends StatefulWidget {
  const PaymentMethodProcess({Key? key}) : super(key: key);

  @override
  State<PaymentMethodProcess> createState() => _PaymentMethodProcessState();
}

class _PaymentMethodProcessState extends State<PaymentMethodProcess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  Text(
                    "Payment Method",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  )
                ],
              ),
              SizedBox(height: 2),
              SvgPicture.asset("assets/bankname.svg"),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Card Holder",
                  style: TextStyle(color: Color(0xff8F92A1),fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Transform.scale(
                      scale: 0.3,
                      child: SvgPicture.asset("assets/PROFIL.svg"),
                    ),
                    hintText: "Oguz Bulbul",hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    contentPadding:  EdgeInsets.all(6)
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Card Number",
                  style: TextStyle(color: Color(0xff8F92A1), fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Transform.scale(
                      scale: 0.3,
                      child: SvgPicture.asset("assets/Ticket Star.svg"),
                    ),
                    hintText: "888532112155",hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                      contentPadding:  EdgeInsets.all(6)
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [SizedBox(height: 10),
                          Text(
                            "Expiry Date 1",
                            style: TextStyle(color: Color(0xff8F92A1), fontSize: 12),
                          ),
                          SizedBox(height: 10),
                          Container(
                            // width: 120, // Adjust the width as needed
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Transform.scale(
                                  scale: 0.3,
                                  child: SvgPicture.asset("assets/Calendar.svg"),
                                ),
                                hintText: "01/2022",hintStyle: TextStyle(color: Colors.black,fontSize: 12),
                                  contentPadding: EdgeInsets.all(6)
                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between the fields
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [SizedBox(height: 10),
                          Text(
                            "Expiry Date 2",
                            style: TextStyle(color: Color(0xff8F92A1),fontSize: 12),
                          ),
                          SizedBox(height: 10),
                          Container(
                            // width: 120, // Adjust the width as needed
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Transform.scale(
                                  scale: 0.3,
                                  child: SvgPicture.asset("assets/Lock.svg",color: Colors.black),
                                ),
                                hintText: "01/2022",hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                                contentPadding: EdgeInsets.all(6)
                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              SizedBox(height: 20), // Adjust the spacing as needed
              TextButton(
                onPressed: () {
                  // Get.to(()=>MainChatScreens());
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.3,
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
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
