import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/Controllers/CreatePostController.dart';
import '../../Controllers/GetuserdataDataController.dart';
import '../../Utis/firebase.dart';
import '../../Widgets/CustomButton.dart';
import 'CreatePost_CustomButton.dart';

class CreatePost extends StatefulWidget {
  final String? imagePath;
  const CreatePost({Key? key, this.imagePath}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());
  String postId = UniqueKey().toString();
  RxBool isLoading = RxBool(false);
  final CreatePostController createPostController =
  Get.put(CreatePostController(), tag: 'createPostController');

  @override
  void initState() {
    super.initState();
    createPostController.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        createPostController
                            .postDescriptionController.clear();
                        createPostController.selectedPostImage.value = null;
                      },
                      icon: const Icon(CupertinoIcons.left_chevron),
                    ),
                    const Text(
                      'Create Post',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                      width: 40,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: ClipOval(
                        child: Image.network(
                          getUserDataController.getUserDataRxModel.value!
                              .profileimage,
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getUserDataController
                              .getUserDataRxModel.value!.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        CreatePost_CustomButtom(
                          'assets/tag.svg',
                          'Tag People',
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        createPostController.pickedPostImage();
                        if (createPostController.selectedPostImage.value !=
                            null) {
                          Rx<File> rxFile = Rx<File>(
                            createPostController.selectedPostImage.value!,
                          );
                          setState(() {});
                        } else {
                          Get.snackbar("No Image", "Please Select Image");
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.024, left: Get.width * 0.12),
                        child: CreatePost_CustomButtom(
                            'assets/addmore.svg', 'Add more'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Column(
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
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: Get.height * 0.4,
                  width: Get.width * 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffAC83F6),
                      borderRadius: BorderRadius.circular(10),
                      image: createPostController.selectedPostImage.value !=
                          null
                          ? DecorationImage(
                        image: FileImage(
                          createPostController.selectedPostImage.value!,
                        ),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    height: Get.height * 0.4,
                    width: Get.width * 0.9,
                    margin: const EdgeInsets.all(8.0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: createPostController.postDescriptionController,
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
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: isLoading.value ? null : onPressed,
                      style: ElevatedButton.styleFrom(fixedSize: const Size(240, 40),
                        primary: const Color(0xffAC83F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text(
                        "upload",
                        style: TextStyle(
                          fontSize: 14,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressed() async {
    isLoading.value = true;
    String postId = uuid.v4();

    if (createPostController.selectedPostImage.value != null) {
      await createPostController.createPostHandler(
        username:
        getUserDataController.getUserDataRxModel.value!.name,
        userProfileImage:
        getUserDataController.getUserDataRxModel.value!.profileimage,
        postId: postId,
        userId: FirebaseAuth.instance.currentUser!.uid,
        userPostImage:
        createPostController.selectedPostImage.value!,
        description:
        createPostController.postDescriptionController.text,
        timestamp: DateTime.now().toUtc().toIso8601String(),
      );
      isLoading.value = false;

    } else {
      Get.snackbar('Error', 'Selected post image is null.');
      isLoading.value = false;
    }
  }
}