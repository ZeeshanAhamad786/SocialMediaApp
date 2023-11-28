// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import 'CurrentBalance.dart';
//
// class BottomNavBarV2 extends StatefulWidget {
//   @override
//   _BottomNavBarV2State createState() => _BottomNavBarV2State();
// }
//
// class _BottomNavBarV2State extends State<BottomNavBarV2> {
//   int currentIndex = 0;
//
//   setBottomBarIndex(index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           if (currentIndex == 0) Home(),
//           if (currentIndex == 1) CurrentBalance(),
//           if (currentIndex == 2) Center(child: Text('Wallet Screen')),
//           if (currentIndex == 3) Center(child: Text('Profile Screen')),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             child: Container(
//               width: size.width,
//               height: 70,
//               child: Stack(
//                 children: [
//                   CustomPaint(
//                     size: Size(size.width, 80),
//                     painter: BNBCustomPainter(),
//                   ),
//                   Center(
//                     widthFactor: 7,
//                     heightFactor: 0.5,
//                     child: FloatingActionButton(
//                       backgroundColor: Colors.blue,
//                       child: Icon(
//                         CupertinoIcons.add,
//                         color: Colors.white,
//                       ),
//                       shape: CircleBorder(),
//                       elevation: 0.1,
//                       onPressed: () async {
//                         // Show your custom dialog here
//                         // await showDialog<String>(
//                         //   context: context,
//                         //   builder: (BuildContext context) {
//                         //     return YourCustomDialog();
//                         //   },
//                         // );
//                       },
//                     ),
//                   ),
//                   Container(
//                     width: size.width,
//                     height: 70,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           icon: SvgPicture.asset(
//                             'assets/home.svg',
//                             color: currentIndex == 0 ? Color(0xff3EA7FF) : null,
//                           ),
//                           onPressed: () {
//                             setBottomBarIndex(0);
//                           },
//                           splashColor: Colors.white,
//                         ),
//                         IconButton(
//                           icon: SvgPicture.asset(
//                             'assets/Chat.svg',
//                             color: currentIndex == 1 ? Color(0xff3EA7FF) : null,
//                           ),
//                           onPressed: () {
//                             setBottomBarIndex(1);
//                           },
//                         ),
//                         Container(
//                           width: size.width * 0.20,
//                         ),
//                         IconButton(
//                           icon: SvgPicture.asset(
//                             'assets/Wallet.svg',
//                             color: currentIndex == 2 ? Color(0xff3EA7FF) : null,
//                           ),
//                           onPressed: () {
//                             setBottomBarIndex(2);
//                           },
//                         ),
//                         IconButton(
//                           icon: SvgPicture.asset(
//                             'assets/Profile.svg',
//                             color: currentIndex == 3 ? Color(0xff3EA7FF) : null,
//                           ),
//                           onPressed: () {
//                             setBottomBarIndex(3);
//                           },
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class BNBCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
//     path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
//     path.arcToPoint(Offset(size.width * 0.55, 20),
//         radius: Radius.circular(20.0), clockwise: false);
//     path.quadraticBezierTo(size.width * 0.55, 0, size.width * 0.60, 0);
//     path.quadraticBezierTo(size.width * 0.75, 0, size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, 0);
//     canvas.drawShadow(path, Colors.black, 5, true);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
//
