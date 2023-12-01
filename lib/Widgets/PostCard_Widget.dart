import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:socialmediaapp/Controllers/CreatePostController.dart';
import 'package:socialmediaapp/View/BottomBarScreens/Home/FeedPost_MoreButton.dart';
import 'package:socialmediaapp/View/BottomBarScreens/Home/SharePost.dart';
import 'package:socialmediaapp/View/BottomBarScreens/Profile/PersnonalPosts_MoreButton.dart';
import 'package:socialmediaapp/View/BottomBarScreens/Profile/Profile.dart';
import '../Controllers/GetuserdataDataController.dart';

import '../Models/postModel.dart';
import 'PicPost_Widget.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final bool ispersonalpost;

  PostCard({required this.post,required this.ispersonalpost});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
  CreatePostController createPostController =
  Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {

    return  Card(
        color: Colors.white,
        elevation: 0.2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(userId:  createPostController.postsList.first.
                        userId,postId:createPostController.postsList.first.
                        postId ,
                            otherUserProfile: !widget.ispersonalpost,profileImage:  createPostController.postsList.first.
                        userProfileImage,profileName: createPostController.postsList.first.
                        username.toString() ), // Replace SecondScreen with the screen you want to navigate to.
                      ),
                    );
                  },
                  child: ProfilePicWidget(
                      picType: 'network',
                      createPostController.postsList.first.
                      userProfileImage, 45, 45),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( createPostController.postsList.isNotEmpty?
                      createPostController.postsList.first.
                      username.toString():"No timestamp available",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      createPostController.postsList.isNotEmpty
                          ? createPostController.postsList.first.timestamp.toString()
                          : 'No timestamp available',
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    )

                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        if(!widget.ispersonalpost){

                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(
                                      25)), // Set circular border radius here
                            ),
                            context: context,
                            builder: (BuildContext context) =>
                                FeedPost_MoreButton(),
                          );}
                        else{
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(
                                      25)), // Set circular border radius here
                            ),
                            context: context,
                            builder: (BuildContext context) =>
                                PersonalPosts_MoreButton(),
                          );}
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                ),
              ],
            ),
              const SizedBox(height: 8.0),
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(25),
                      ),
                      image: DecorationImage(
                        image: createPostController.postsList.isNotEmpty &&
                            createPostController.postsList.first.userPostImage.isNotEmpty
                            ? NetworkImage(createPostController.postsList.first.userPostImage) as ImageProvider<Object>
                            : AssetImage('assets/profilepic.png') as ImageProvider<Object>, // Replace with your placeholder image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            '3/10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/like.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.post.likes,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/comment.svg',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.post.comeents,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(
                                      25)), // Set circular border radius here
                            ),
                            context: context,
                            builder: (BuildContext context) => MyBottomSheet(),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/send.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      // Toggle the postsaved state
                    },
                    child: widget.post.postsaved
                        ? SvgPicture.asset(
                      'assets/save_blue.svg',
                      height: 20,
                      width: 20,
                    )
                        : SvgPicture.asset(
                      'assets/save.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                createPostController.postsList.first.description.isNotEmpty?
                createPostController.postsList.first.description:"No Description",
                style: const TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 3.0),
              Wrap(
                children: widget.post.hashtags
                    .map((hashtag) => Text(
                  '#$hashtag ',
                  style: const TextStyle(color: Color(0xff7F7F7F),fontSize: 13),
                ))
                    .toList(),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
    );
  }
}