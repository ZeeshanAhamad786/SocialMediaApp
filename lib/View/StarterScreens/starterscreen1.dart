import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Login_Screens/Sign_In.dart';
import 'ContinueWithGoogle.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                buildOnBoardScreen(
                  'assets/Group 11749.svg',
                  'Discover, Connect, and Share the Moments that Matter.',
                  'Step into a world of endless possibilities and connections with our social media platform. From sharing life\'s highlights to exploring new horizons, our app is your gateway to a vibrant social experience. Start connecting today and let the journey unfold!',
                ),

                buildOnBoardScreen(
                  'assets/Group 11795.svg',
                  'Discover, Connect, and Share the Moments that Matter.',
                  'Step into a world of endless possibilities and connections with our social media platform. From sharing life\'s highlights to exploring new horizons, our app is your gateway to a vibrant social experience. Start connecting today and let the journey unfold!',
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),

          if (_currentPage == 1) // Show text on the last page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                onPressed: () {
                  Get.to(()=>ContinueWithGoogle());
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5,
                      ),
                    ],
                    color: Color(0xffAC83F6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "Let's Started",
                      style: TextStyle(color: Colors.white,fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          if (_currentPage == 0) // Show text button on the first page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                onPressed: () {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },

                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5,
                      ),
                    ],
                    color: Color(0xffAC83F6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }

  Widget buildOnBoardScreen(
      String imagePath,
      String heading,
      String description,
      ) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.13,
            ),
            child: SvgPicture.asset(
              imagePath,
              width: 300,
              height: 240,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
        Center(
          child: SmoothPageIndicator(
            controller: _controller,
            count: 2, // Update the count to match the number of pages
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xff132183),
              dotColor: Color(0xff132183),
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ),

      ],
    );
  }
}

