import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/Models/commentsModel.dart';
import '../../Controllers/CreatePostController.dart';
import '../../Controllers/GetuserdataDataController.dart';
class CommentsScreen extends StatefulWidget {
  final String postId;
List postComments=[];
  CommentsScreen({required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  CreatePostController createPostController = Get.put(CreatePostController());
  GetUserDataController getUserDataController = Get.put(GetUserDataController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,size: 18),

            onPressed: () {
              Navigator.pop(context);
            },
          ),

        elevation: 0,
        title:Obx(() =>

            Text(
          'Comments (${
              createPostController.comments
                  .where((comment) => comment.postId == widget.postId)
                  .toList().length
          })',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),)

      ),
      body: Column(
        children: [
          const Divider(color: Colors.grey, thickness: 1,),
          Expanded(
            child: FutureBuilder(
              future: createPostController.fetchAllComments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading comments'));
                } else {
                  // Filter comments based on postId
                  List<commentModel1> postComments = createPostController.comments
                      .where((comment) => comment.postId == widget.postId)
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: postComments.length,
                    itemBuilder: (context, index) {
                      var comment = postComments[index];
                      log('Comments: ${comment.userProfileImage}');
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(comment.userProfileImage),),
                        title: Text(comment.userName),
                        subtitle: Text(comment.comment),
                      );
                    },
                  );
                }
              },
            )

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

                    if (commentController.text.isNotEmpty) {
                    setState(() {
                      createPostController.addCommentToDatabase(
                        getUserDataController.getUserDataRxModel.value!.profileimage,
                        widget.postId,
                        FirebaseAuth.instance.currentUser!.uid,
                        commentText,
                        getUserDataController.getUserDataRxModel.value!.name,
                      );
                    });
                    }

                    commentController.clear();
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
