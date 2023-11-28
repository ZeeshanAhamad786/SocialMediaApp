import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/SharePost_Model.dart';
import 'CustomButton.dart';
import 'PicPost_Widget.dart';

class SharePost_Widget extends StatefulWidget {
  SharePost_Model sharepost;
  SharePost_Widget({Key? key,required this.sharepost}) : super(key: key);

  @override
  State<SharePost_Widget> createState() => _SharePost_WidgetState();
}

class _SharePost_WidgetState extends State<SharePost_Widget> {
  bool option1 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          ProfilePicWidget(widget.sharepost.image, 45, 45),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.sharepost.name,
            style: TextStyle(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: CircularCheckBox(
                value: widget.sharepost.wantSend,
                onChanged: (newValue) {
                  setState(() {
                    widget.sharepost.wantSend = newValue!;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircularCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CircularCheckBox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? Colors.blue :Colors.white,
          border: Border.all(
            width: 2.0,
            color: value ? Colors.blue :Colors.grey,
          ),
        ),

      ),
    );
  }
}

Widget YeswanttoSend_Widget(){
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
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
              hintText: 'Write message here....',
              hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
              contentPadding: EdgeInsets.only(bottom: 12.0,left: 15),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: CustomButton(text: 'Send', onPressed: () {  },),
        ),
        SizedBox(height: 10,)
      ],
    ),
  );
}
