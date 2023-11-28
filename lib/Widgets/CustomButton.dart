import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (text == 'Follow' || text == 'Message' ) {
      return profilescreenbuttons(context);
    } else {
      return otherbutton(context);
    }
  }
  Widget otherbutton(BuildContext context){
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                spreadRadius:  text=='Draft' || text=='Skip for now' || text=='Allow' ?1 :0,
                color: Colors.grey.withOpacity(0.4)
            )
          ],
          color: text=='Draft' || text=='Skip for now' || text=='Allow' ?Colors.white :Color(0xffAC83F6)
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: text=='Draft' || text=='Skip for now' || text=='Allow' ? Color(0xffAC83F6) : Colors.white,fontSize: 13),
        ),
      ),
    );
  }
  Widget profilescreenbuttons(BuildContext context){
    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          color:Color(0xffAC83F6)
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white,fontSize: 10),
        ),
      ),
    );
  }
}