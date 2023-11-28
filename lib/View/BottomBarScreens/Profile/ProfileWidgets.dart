import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Accountdata_Widget(String text,String number){
  return  Column(
    children: [
      Text(number,style: TextStyle(color:Colors.black,fontSize: 17),textAlign: TextAlign.center,),
      SizedBox(height: 2,),
      Text(text,style: TextStyle(color:Colors.grey,fontSize: 12 ),textAlign: TextAlign.center,),


    ],
  );
}