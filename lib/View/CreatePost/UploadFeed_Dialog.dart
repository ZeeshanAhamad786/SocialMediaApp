import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'CreatePost.dart';

class UploadFedd_Dialog extends StatelessWidget {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _getImageFromCamera(BuildContext context) async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.pop(context); // Close the dialog
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePost(imagePath: image.path),
        ),
      );
    }
  }
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
                  IconButton( onPressed: () => _getImageFromCamera(context),

                    icon: SvgPicture.asset('assets/Camera.svg')),
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
