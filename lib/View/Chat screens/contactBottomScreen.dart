import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Widgets/CustomButton.dart';

class contactBottomList extends StatelessWidget {
  const contactBottomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Divider(
              color: Colors.black,thickness: 1,
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          Center(child: SvgPicture.asset("assets/Profile.svg")),
          SizedBox(
            height: size.height / 50,
          ),
          Text("Allow to access your Contact ?",style: TextStyle(color: Colors.black,fontSize: 12)),
          SizedBox(
            height: size.height / 20,
          ),
          Text(
            "Allow",
            style: TextStyle(color: Color(0xffAC83F6)),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          CustomButton(
            text: "Don't Allow", onPressed: () {},

            //   onPressed: ()=>registerVM.signUp(),
          ),
        ]),
      ),
    );
  }
}
