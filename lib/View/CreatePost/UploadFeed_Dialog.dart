import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CreatePost.dart';

class UploadFedd_Dialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25
        ), // Set circular border radius here
      ),
      title: Center(child: Text("Upload Feed",style: TextStyle(fontSize: 14),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Row(
              children: [

              Expanded(
                  flex: 1,child:Column(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePost(),
                      ),);
                  }, icon: SvgPicture.asset('assets/Camera.svg')),
                  // SizedBox(height: 5,),
                  Text('Take Photo',style: TextStyle(fontSize: 14),)
                ],
              ))  ,
                Expanded(
                    flex: 1,child:Column(
                  children: [
                    IconButton(onPressed: (){ Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePost(),
                      ),);}, icon: SvgPicture.asset('assets/gallery.svg')),
                    // SizedBox(height: 5,),
                    Text('From Gallery',style: TextStyle(fontSize: 14)),
                  ],
                ))
              ],
            ),

          SizedBox(height: 20,),

        ],
      ),
    );
  }
}
