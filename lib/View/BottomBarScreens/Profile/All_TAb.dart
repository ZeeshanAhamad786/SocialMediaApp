import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/CreatePostController.dart';
import '../../../Models/ProfileModels.dart';

class All_Tab extends StatefulWidget {
  ProfileModel userprofile;

  All_Tab({Key? key, required this.userprofile}) : super(key: key);

  @override
  State<All_Tab> createState() => _All_TabState();
}

class _All_TabState extends State<All_Tab> {
  CreatePostController createPostController = Get.put(CreatePostController());

  List<String> media = [];

  addPosts() async {
    media.clear();
    for (var post in createPostController.postsList) {
      if (post.userId == FirebaseAuth.instance.currentUser!.uid) {
          media.add(post.userPostImage);
      }
    }
    log(media.toString());
  }


  @override
  Widget build(BuildContext context) {
    addPosts();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
          child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 8.0,
        ),
        scrollDirection: Axis.vertical,
        itemCount: media.length,
        itemBuilder: (BuildContext context, int index) {
          return  Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(media[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ); // or any other placeholder widget
        },
      )),
    );
  }
}
