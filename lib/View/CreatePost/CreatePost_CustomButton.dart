import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget CreatePost_CustomButtom(
String icon,
String text,
){
  return  Container(
    height: 30,
    width: 100,
    decoration: BoxDecoration(
        color: Color(0xff3EA7FF).withOpacity(0.25),
        borderRadius: BorderRadius.circular(20)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 5,),
        Text(
          // Format the timestamp as needed
          text,
          style: TextStyle(color: Colors.black,fontSize: 11),
        ),
      ],
    ),
  );
}