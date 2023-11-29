import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/CreatePostController.dart';
import '../../Controllers/GetuserdataDataController.dart';
import '../../Models/CreatePostModel.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key,required String postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  String currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();
  CreatePostController createPostController = Get.put(CreatePostController());
  CreatePostModel? selectedPost;

  GetUserDataController getUserDataController =
  Get.put(GetUserDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Comments (20)",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(color: Colors.grey, thickness: 1,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder: (context, index) {
                var post = createPostController.postsList[index];
                return Column(
                  children: [
                    const ListTile(
                      leading: CircleAvatar(),
                      title: Text("Ali Raza"),
                      subtitle: Text("My Name Is Ali am Working On Socail Media App"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            createPostController.toggleLikeForPost(post.postId);
                          },
                          child: Obx(() => Icon(
                            CupertinoIcons.heart_fill,
                            size: 20,
                            color: post.likes.any((like) => like.userId == currentUserId)
                                ? CupertinoColors.systemPink
                                : CupertinoColors.systemGrey,
                          )),
                        ),
                        const SizedBox(width: 5),
                        Obx(() => Text(
                          post.likes.length.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        )),
                        const SizedBox(width: 15),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedPost = post;
                            });
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey.withOpacity(0.2), thickness: 1,),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    final String commentText = commentController.text;
                    if (commentText.isNotEmpty ) {
                      createPostController.addCommentToDatabase(
                        getUserDataController.getUserDataRxModel.value!.profileimage,
                        createPostController.postsList.first.postId.isNotEmpty
                            ? createPostController.postsList.first.postId
                            : "No Description",
                        FirebaseAuth.instance.currentUser!.uid,
                        commentText,
                        getUserDataController.getUserDataRxModel.value!.name.toString(),
                      );

                      commentController.clear();

                    }
                  },
                  icon: const Icon(Icons.send, size: 18),
                ),
                hintText: 'What is your Comment',
                hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }
}

