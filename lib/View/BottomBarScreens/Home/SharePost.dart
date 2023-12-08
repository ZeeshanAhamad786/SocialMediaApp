
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmediaapp/Widgets/SharePost_Widget.dart';

import '../../../Models/SharePost_Model.dart';

class MyBottomSheet extends StatelessWidget {

  final List<SharePost_Model> items = [
    SharePost_Model(image: 'assets/model1.jpg', name: 'Minha Anjum', wantSend: true),
    SharePost_Model(image: 'assets/model2.jpg', name: 'John Doe', wantSend: false),
    SharePost_Model(image: 'assets/model3.jpg', name: 'Alice Smith', wantSend: false),
    SharePost_Model(image: 'assets/model4.jpg', name: 'Mia', wantSend: false),
    SharePost_Model(image: 'assets/model1.jpg', name: 'Minha Anjum', wantSend: false),
    SharePost_Model(image: 'assets/model2.jpg', name: 'John Doe', wantSend: false),
    SharePost_Model(image: 'assets/model3.jpg', name: 'Alice Smith', wantSend: false),
    SharePost_Model(image: 'assets/model4.jpg', name: 'Mia', wantSend: false),
    SharePost_Model(image: 'assets/model1.jpg', name: 'Minha Anjum', wantSend: false),
    SharePost_Model(image: 'assets/model2.jpg', name: 'John Doe', wantSend: false),
    SharePost_Model(image: 'assets/model3.jpg', name: 'Alice Smith', wantSend: false),
    SharePost_Model(image: 'assets/model4.jpg', name: 'Mia', wantSend: false),

    // Add more items as needed
  ];
  List<DocumentSnapshot<Map<String, dynamic>>> selectedFollowers = [];
  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) => item.wantSend).toList();

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height*0.55, // Adjust the height as needed
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5,),
            Container(height: 3,width: 90,
            color: Color(0xff707070),),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                    prefixIcon: Transform.scale(
                        scale: 0.5,
                        child: SvgPicture.asset('assets/search.svg',color: Colors.grey.withOpacity(0.3),)),
                    hintText: 'Search here',
                    hintStyle: TextStyle(fontSize: 13,color: Colors.grey),

                    contentPadding: EdgeInsets.only(bottom: 12.0,left: 15),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return SharePost_Widget(sharepost: items[index]);
                      },
                    ),
                  ),
                  if (filteredItems.isNotEmpty) // Check if there are items with wantSend == true

                    Positioned(
                    bottom: 0, // Aligns the widget at the bottom
                    left: 0,   // You can adjust left and right positioning as needed
                    right: 0,  // You can adjust left and right positioning as needed
                    child: YeswanttoSend_Widget(),
                  ),
                ],
              ),
            ),

            // YeswanttoSend_Widget()
        ],
        ),
      ),
    );
  }
}
