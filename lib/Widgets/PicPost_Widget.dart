import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget ProfilePicWidget(String picUrl, double height, double width,
    {String picType = 'assets', }) {
  return Container(
    width: width, // Width of the circular image container
    height: height, // Height of the circular image container
    child: ClipOval(
      child: picType == 'network'
          ? Image.network(
              picUrl, // Replace with your image URL
              width: width, // Width of the circular image
              height: height, // Height of the circular image
              fit: BoxFit
                  .cover, // Adjust this to control how the image fits inside the circular shape
            )
          : Image.asset(
              picUrl, // Replace with your image URL
              width: width, // Width of the circular image
              height: height, // Height of the circular image
              fit: BoxFit
                  .cover, // Adjust this to control how the image fits inside the circular shape
            ),
    ),
  );
}

// Widget PostPicWidget(String pic) {
//   return Container(
//     height: 240,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(25),
//           topLeft: Radius.circular(5),
//           bottomRight: Radius.circular(5),
//           bottomLeft: Radius.circular(25),
//         ),
//         image: DecorationImage(
//             image: NetworkImage('assets/profilepic.png'), fit: BoxFit.cover)),
//   );
// }


