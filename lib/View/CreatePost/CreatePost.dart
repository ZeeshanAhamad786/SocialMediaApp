import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/Controllers/CreatePostController.dart';


import '../../Controllers/GetuserdataDataController.dart';
import '../../Models/CreatePostModel.dart';
import '../../Utis/firebase.dart';
import '../../Widgets/CustomButton.dart';

import 'CreatePost_CustomButton.dart';

class CreatePost extends StatefulWidget {
  CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
// Generate a unique postId using UniqueKey
  String postId = UniqueKey().toString();

  final CreatePostController createPostController =
      Get.put(CreatePostController(), tag: 'createPostController');
  @override
  void initState() {
    super.initState();
    createPostController.getAllPosts();
  }

  late final List<CreatePostModel> postsList;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            createPostController.postDescriptionController.clear();
                            createPostController.selectedPostImage.value==null;
                          },
                          icon: Icon(CupertinoIcons.left_chevron)),
                      Text(
                        'Create Post',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50.0, // Width of the circular image container
                        height: 50.0, // Height of the circular image container
                        child: ClipOval(
                          child: Image.network(
                            getUserDataController.getUserDataRxModel.value!
                                .profileimage, // Replace with your image URL
                            width: 150.0, // Width of the circular image
                            height: 150.0, // Height of the circular image
                            fit: BoxFit
                                .cover, // Adjust this to control how the image fits inside the circular shape
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getUserDataController
                                .getUserDataRxModel.value!.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          CreatePost_CustomButtom(
                              'assets/tag.svg', 'Tag People')
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          createPostController.pickedPostImage();
                          if (createPostController.selectedPostImage.value !=
                              null) {
                            // Convert the File object to Rx<File>
                            Rx<File> rxFile = Rx<File>(
                                createPostController.selectedPostImage.value!);

                            setState(() {

                            });

                          } else {
                            Get.snackbar("No Image", "Please Select Image");
                          }
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(top: Get.height*0.024,left: Get.width*0.12),
                          child: CreatePost_CustomButtom(
                              'assets/addmore.svg', 'Add more'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"Lost in the beauty of natures embrace. 🌿🌄"',
                            style: TextStyle(fontSize: 13.0),
                          ),
                          Text(
                            '#Wanderlust #NatureLover',
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/emoji.svg',
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: Get.height * 0.4,
                    width: Get.width * 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffAC83F6),
                        borderRadius: BorderRadius.circular(10),
                        image: createPostController.selectedPostImage.value != null
                            ? DecorationImage(
                          image: FileImage(createPostController.selectedPostImage.value!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      height: Get.height * 0.4,
                      width: Get.width * 0.9,
                      margin: const EdgeInsets.all(8.0),
                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:
                          createPostController.postDescriptionController,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        hintText: 'description',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        contentPadding: const EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffAC83F6),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child:CustomButton(
                        text: 'Upload',
                        onPressed: () async {
                          String postId = uuid.v4();

                          // Use image picker to get the selected image file

                          // Check if selectedPostImage is not null before calling createPostHandler
                          if (createPostController.selectedPostImage.value != null) {
                            createPostController.createPostHandler(
                              username: getUserDataController.getUserDataRxModel.value!.name,
                              userProfileImage:
                              getUserDataController.getUserDataRxModel.value!.profileimage,
                              postId: postId,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              userPostImage:
                              createPostController.selectedPostImage.value!, // Use ! to assert non-null
                              description: createPostController.postDescriptionController.text,
                              timestamp: DateTime.now().toUtc().toIso8601String(),
                            );
                          } else {
                            // Show a snackbar or handle the case where selectedPostImage is null
                            Get.snackbar('Error', 'Selected post image is null.');
                          }
                        },
                      ),

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: CustomButton(
                      text: 'Draft',
                      onPressed: () {
                        // Navigator.push(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) => CreatePost(),
                        // ),);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
