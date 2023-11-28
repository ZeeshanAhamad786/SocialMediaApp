import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Widgets/CustomButton.dart';
import 'ContactsPermission_Dialog.dart';

class ContactsPermission extends StatelessWidget {
  const ContactsPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: Get.height*0.1,),
              Align(alignment: Alignment.centerLeft,
                  child: InkWell(onTap: () {
                    Get.back();
                  },
                      child: Icon(Icons.arrow_back_ios, size: 15,))),
              SizedBox(height: 10,),
              SvgPicture.asset('assets/contactspermission.svg',height: 250,width: 250,),
              SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,
                  child: Text("  See who's on your Contact",style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w400),)),
              SizedBox(height: Get.height*0.01,),
              Align(alignment: Alignment.centerLeft,
                  child: Text("Syncing your contacts is on way to find people to follow and build your timeline .",style: TextStyle(color: Colors.black,fontSize: 10),)),
              SizedBox(height: 20,),
              Row(
                children: [
                  SvgPicture.asset('assets/Profile2.svg',height: 20,width: 20),
                  SizedBox(width: 20,),
                  Text('You decide who to follow',style: TextStyle(fontSize: 14),)
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SvgPicture.asset('assets/joins.svg',height: 20,width: 20,),
                  SizedBox(width: 20,),
                  Text('Get notified when someone you know joins ',style: TextStyle(fontSize: 14))
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SvgPicture.asset('assets/sync.svg',height: 20,width: 20,),
                  SizedBox(width: 20,),
                  Text('Turn off syncing at any time ',style: TextStyle(fontSize: 14))
                ],
              ),
          SizedBox(height: 20,),
              RichText(
                text: TextSpan(
                  // Default style for the entire text

                  children: <TextSpan>[
                    TextSpan(
                      text: '"Step into a world of endless possibilities and connections with our social media platform. From sharing lifes highlights to exploring new horizons, our app is your gateway to a vibrant social experience. Start connecting today and let the journey unfold!" ',
                      style: TextStyle(fontSize: 12,
                        color: Colors.grey,

                      ),
                    ),
                    TextSpan(
                      text: '  Learn more',
                      style: TextStyle(fontSize: 12,
                        color: Color(0xff3EA7FF),

                      ),
                    ),
                  ],
                ),),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(
                                25)), // Set circular border radius here
                      ),
                      context: context,
                      builder: (BuildContext context) =>
                          ContactsPermission_Dialog(),
                    );
                  },
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
