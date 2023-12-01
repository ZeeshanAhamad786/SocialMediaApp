
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/View/CreatePost/CommentsScreen.dart';


import '../../../Controllers/CreatePostController.dart';
import '../../../Controllers/GetuserdataDataController.dart';

import '../../../Models/postModel.dart';
import '../../../Widgets/PicPost_Widget.dart';

import '../Profile/PersnonalPosts_MoreButton.dart';
import '../Profile/Profile.dart';
import 'FeedPost_MoreButton.dart';
import 'SharePost.dart';

// Define the PostController and Post classes here (same as in your code)

class PostFeedScreen extends StatefulWidget {
  bool saved_posts_Screen;
  final bool ispersonalpost;

  PostFeedScreen({super.key, required this.saved_posts_Screen,required this.ispersonalpost});

  @override
  State<PostFeedScreen> createState() => _PostFeedScreenState();
}

class _PostFeedScreenState extends State<PostFeedScreen> {
  // Create a list of posts (you can replace this with actual data)
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
  final List<PostModel> posts = [
    PostModel(
      name: 'John Doe',
      post: 'Lorem ipsum dolor sit amet...',
      profilepic: 'assets/profilepic.png',
      postpic: 'assets/model1.jpg',
      caption: '"Lost in the beauty of natures embrace. 🌿🌄',
      timestamp: '10 min ago',
      likes: '2555',
      comeents: '2',
      postsaved: true,
      hashtags: ['nature', 'sunset'],
    ),
    PostModel(
      name: 'Jane Smith',
      post: 'Sed ut perspiciatis unde omnis iste...',
      profilepic: 'assets/profilepic.png',
      postpic: 'assets/model4.jpg',
      caption: 'Exploring new places!',
      timestamp: '15 min ago',
      likes: '10',
      comeents: '3',
      postsaved: true,

      hashtags: ['travel', 'adventure'],
    ),
    PostModel(
      name: 'Jane Smith',
      post: 'Sed ut perspiciatis unde omnis iste...',
      profilepic: 'assets/profilepic.png',
      postpic:'assets/model2.jpg',
      caption: 'Exploring new places!',
      timestamp: '15 min ago',
      likes: '10',
      comeents: '3',
      postsaved: false,

      hashtags: ['travel', 'adventure'],
    ),
    PostModel(
      name: 'Jane Smith',
      post: 'Sed ut perspiciatis unde omnis iste...',
      profilepic: 'assets/profilepic.png',
      postpic: 'assets/model3.jpg',

      caption: 'Exploring new places!',
      timestamp: '15 min ago',
      likes: '10',
      comeents: '3',
      postsaved: false,

      hashtags: ['travel', 'adventure'],
    ),
    // Add more posts as needed
  ];



String currentUserId=FirebaseAuth.instance.currentUser!.uid.toString();
  CreatePostController createPostController =
  Get.put(CreatePostController());

  @override
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


  // Color of the SVG image
  @override
  Widget build(BuildContext context) {
    // Filter posts based on saved_posts_Screen value

    return Obx(()=> Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: createPostController.postsList.length,
          itemBuilder: (context, index) {
            var post = createPostController.postsList[index];
            if (post!=null){ return  Padding(
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
                              builder: (context) => Profile(userId: post.userId,postId: post.postId,
                                otherUserProfile: !widget.ispersonalpost,profileImage: post.userProfileImage,

                              profileName: post.username,
                              ), // Replace SecondScreen with the screen you want to navigate to.
                            ),
                          );
                        },
                        child: ProfilePicWidget(
                            picType: 'network',
                        post.userId==post.postId?
                        getUserDataController.getUserDataRxModel.value!.profileimage:post.userProfileImage, 45, 45),
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
                            image: createPostController.postsList.isNotEmpty
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
                          createPostController.toggleLikeForPost(post.postId);
                        },
                        child: Obx(() => Icon(
                          CupertinoIcons.heart_fill,
                          size: 25,
                          color: post.likes.any((like) => like.userId == FirebaseAuth.instance.currentUser!.uid)
                              ? CupertinoColors.systemPink
                              : CupertinoColors.systemGrey,
                        )),
                      ),


                      const SizedBox(width: 5),
                     Obx(() =>  Text(
                       post.likes.length.toString(),
                       style: TextStyle(fontWeight: FontWeight.w300),
                     ),),

                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            // Assuming you have access to the current post in the loop


                            // Pass the postId to CommentsScreen
                            return CommentsScreen(postId: post.postId);
                          }));
                        },
                        child: SvgPicture.asset(
                          'assets/comment.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),

                      const SizedBox(width: 5),
                      Obx(() =>  Text(
                        "   ${  createPostController.comments.where((comment) => comment.postId==post.postId).toList().length}",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),),
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
              return const Center(child:  CircularProgressIndicator(   color: Color(0xffAC83F6),));
            }


          },
        ),
      ),
    );
  }

}