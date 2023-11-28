import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final validation;
  CustomTextField({
    this.validation,
    required this.hintText,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

          TextFormField(
            validator: validation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
              enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(25)),
              hintText: hintText,
              hintStyle:  TextStyle(
                color: Color(0xff707070),
                fontSize: 10,
              ),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              // Remove border for read-only field

            ),
          ),

      ],
    );
  }
}
