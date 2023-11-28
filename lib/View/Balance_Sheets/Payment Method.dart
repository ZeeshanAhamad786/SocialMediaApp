import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Widgets/SharePost_Widget.dart';
import 'Payment Method Process.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isRadioSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
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
                      )),
                  Text(
                    "Payment Method",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              SizedBox(
                  height: Get.height*0.04
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    SizedBox(width: 5),
                    SvgPicture.asset("assets/card.svg"),
                    Text(
                      "By Debit Card",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 15,
                          width: 15,
                          child: CircularCheckBox(
                            value: isRadioSelected,
                            onChanged: (value) {
                              setState(() {
                                isRadioSelected = !isRadioSelected;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                  height: Get.height*0.02
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    SizedBox(width: 5),
                    SvgPicture.asset("assets/paypal.svg"),
                    SizedBox(width: 5),
                    Text(
                      "By Paypal",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 15,
                          width: 15,
                          child: CircularCheckBox(
                            value: !isRadioSelected,
                            onChanged: (value) {
                              setState(() {
                                isRadioSelected = !isRadioSelected;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                  height: Get.height*0.1
              ),
              TextButton(
                onPressed: () {
                  // Get.to(()=>PaymentMethodProcess());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentMethodProcess()),
                  );
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
                    borderRadius:
                    BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),

            ])));
  }
}