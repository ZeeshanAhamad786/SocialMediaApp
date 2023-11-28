import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controllers/CreatePostController.dart';
import '../View/BottomBarScreens/Home/FeedPost_MoreButton.dart';
import '../View/BottomBarScreens/Home/SharePost.dart';
import '../View/BottomBarScreens/Profile/PersnonalPosts_MoreButton.dart';
import '../View/BottomBarScreens/Profile/Profile.dart';
import 'PicPost_Widget.dart';
class ListViewBuilder extends StatefulWidget {
  var saved_posts_Screen;

  var ispersonalpost;

   ListViewBuilder({super.key,required this.saved_posts_Screen,required this.ispersonalpost});


  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  bool ispressed = false;
  CreatePostController createPostController =
  Get.put(CreatePostController());
  void initState() {
    createPostController.getAllPosts();
    print("Posts List Length: ${createPostController.postsList.length}");

    if (createPostController.postsList.isNotEmpty) {
      for (var post in createPostController.postsList) {
        print("Username: ${post.username}");
        print("Post Image: ${post.userPostImage}");
        print("Profile Image: ${post.userProfileImage}");
        // Add more properties as needed
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: createPostController.postsList.length,
      itemBuilder: (context, index) {
        var post = createPostController.postsList[index];
        if (post != null && post.userId == FirebaseAuth.instance.currentUser!.uid){ return  Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(otherUserProfile: !widget.ispersonalpost), // Replace SecondScreen with the screen you want to navigate to.
                        ),
                      );
                    },
                    child: ProfilePicWidget(
                        picType: 'network',
                        post.userProfileImage, 45, 45),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.
                        username.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        post.timestamp.toString()
                        ,
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
                            post.userPostImage != null
                            ? NetworkImage(post.userPostImage) as ImageProvider<Object>
                            : AssetImage('assets/profilepic.png') as ImageProvider<Object>,
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
                    onTap: () {

                    },
                    child: SvgPicture.asset(
                      'assets/like.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "50",
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
                    "300",
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
                      child:
                      SvgPicture.asset(
                        'assets/save_blue.svg',
                        height: 20,
                        width: 20,
                      )

                  ),
                ],
              ), const SizedBox(height: 10),
              Text(

                post.description,
                style: const TextStyle(fontSize: 13.0),
              ),
              const SizedBox(height: 3.0),

              Text(
                '#hashtag ',
                style: const TextStyle(color: Color(0xff7F7F7F),fontSize: 13),
              ),


              const SizedBox(height: 16.0),
            ],
          ),
        ) ;}
        else{
          return const Center(child: null);
        }


      },
    );
  }
}
