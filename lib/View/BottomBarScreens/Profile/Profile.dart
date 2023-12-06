
import 'dart:developer';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../Controllers/CreatePostController.dart';
import '../../../Controllers/GetuserdataDataController.dart';
import '../../../Controllers/ProfileController.dart';

import '../../../Widgets/CustomButton.dart';
import '../../../Widgets/PicPost_Widget.dart';

import '../../Chat screens/ChatRoomScreen.dart';
import '../../CreatePost/CommentsScreen.dart';
import '../Home/PostsFeedScreen.dart';
import '../Home/SharePost.dart';

import 'Profile Edit/Profile_Edit.dart';
import 'ProfileWidgets.dart';
import 'Profile_MoreButton.dart';
String chatRoomId1 =Uuid().v1();


String chatRoomId(String user1, String user2) {
  if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
    return "$user1$user2";
  } else {
    return "$user2$user1";
  }
}
class Profile extends StatefulWidget {
  final bool otherUserProfile;

  final String profileImage;
  final String profileName;
  final String userId;
  final String postId;


  const Profile({Key? key,required this.postId, required this.otherUserProfile, required this.profileImage, required this.profileName, required this.userId,}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>with WidgetsBindingObserver {
  CreatePostController createPostController = Get.put(CreatePostController());
  final ProfileController controller = Get.put(ProfileController());

  bool isFollowing = false;
  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;

    });
    if(isFollowing){
      controller.unfollowUser(_auth.currentUser!.uid,widget.userId);
    }else{

      controller.followUser(_auth.currentUser!.uid,widget.userId);
    }

  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Map<String, dynamic> userMap = {};
  GetUserDataController getUserDataController = Get.put(GetUserDataController());




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore
        .collection("users")
        .doc(widget.userId)
        .update({"status": status});
  }


  void onMessageButtonTap() {
    String roomId = widget.otherUserProfile
        ? chatRoomId(
      getUserDataController.getUserDataRxModel.value!.name,
      widget.profileName ?? "",
    )
        : Uuid().v1(); // Generate a UUID if otherUserProfile is false

    Get.to(() => ChatRoom(
      chatRoomId: roomId,
      userMap: {
        "name": widget.profileName,
        "photoUrl": widget.profileImage,
      },
      userId: widget.userId, profileName: widget.profileName,profilrImage: widget.profileImage,
    ));
  }




  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  var ispersonalpost;

  List<String> media = [];

  addPosts() async {
    media.clear();
    for (var post in createPostController.postsList) {
      if (post.userId == widget.userId) {
        media.add(post.userPostImage);
      }
    }
    log(media.toString());
  }

  @override
  Widget build(BuildContext context) {
    addPosts();
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 27),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.left_chevron,
                    color: Colors.black,
                  ),
                  iconSize: 18,
                ),
              ),
              automaticallyImplyLeading: false,
              expandedHeight: 400,
              pinned: true,
              title: innerBoxIsScrolled && (widget.otherUserProfile || !widget.otherUserProfile)
                  ? Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: widget.otherUserProfile
                              ? SizedBox(
                              height: 25,
                              width: 80,
                              child: CustomButton(
                                  text: 'Follow', onPressed: () {



                              }))
                              : IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                            iconSize: 20,
                          )),
                    )
                  ],
                ),
              )
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    final userProfile = controller.userProfile.value;

                    return Stack(
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.userId==   getUserDataController
                                          .getUserDataRxModel.value!.userId?
                                      getUserDataController.getUserDataRxModel.value!.backgroundImage:
                                      ""
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 50),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(
                                                25)), // Set circular border radius here
                                      ),
                                      context: context,
                                      builder: (BuildContext context) =>
                                          Profile_MoreButton(
                                            otherUserProfile:
                                            widget.otherUserProfile,
                                          ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ProfilePicWidget(
                                      picType: 'network',
                                      widget.profileImage,
                                      95,
                                      95,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          widget.profileName, // Use null-aware operators
                                          style: const TextStyle(
                                            color: Color(0xff3EA7FF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        if (widget.otherUserProfile)
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                height: 30,
                                                width: 95,
                                                child: CustomButton(
                                                  text: 'Message',
                                                  onPressed: onMessageButtonTap,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (widget.otherUserProfile)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: SizedBox(
                                              height: 30,
                                              width: 80,
                                              child: ElevatedButton(

                                                onPressed:  toggleFollow,
                                                style: ElevatedButton.styleFrom(
                                                  primary: isFollowing?  Color(0xffAC83F6):Colors.white,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),  side: isFollowing?const BorderSide(color: Color(0xffAC83F6)):BorderSide(color: Color(0xffAC83F6))

                                                  ),
                                                ),
                                                child:isFollowing? const Text(
                                                  "Follow",
                                                  style: TextStyle(color:Colors.white,fontSize: 13),
                                                ): const Text(
                                                  "UnFollow",
                                                  style: TextStyle(color:Colors.black,fontSize: 11),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!widget.otherUserProfile)
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: SizedBox(
                                                height: 30,
                                                width: 120,
                                                child: CustomButton(
                                                  text: 'Edit Profile',
                                                  onPressed: () {
                                                    Get.to(const ProfileEdit());
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: getUserDataController
                                          .getUserDataRxModel.value!.userId==widget.userId?
                                      Text(
                                        getUserDataController
                                            .getUserDataRxModel.value!.bio,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.start,
                                      ):Text('data')
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: createPostController.postsList
                                      .where((post) => post.userId == widget.userId )
                                      .isNotEmpty
                                      ? Accountdata_Widget(
                                    "Post",
                                    createPostController.postsList.length.toString(),
                                  )
                                      : Container(), // or any other widget you want to display when the condition is not met

                                ),
                                Expanded(
                                  child:FutureBuilder<List<String>>(
                                    future: controller.getFollowers(widget.userId),
                                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return Text('Press button to start.');
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return Text('Awaiting result...');
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else {
                                            // Use the snapshot.data to get the list of followers
                                            List<String> followers = snapshot.data ?? [];

                                            return Column(
                                              children: [
                                                Text(
                                                  ' ${followers.length}', // Display the count of followers
                                                  style:  const TextStyle(color:Colors.black,fontSize: 17),textAlign: TextAlign.center,
                                                ),const Text(
                                                  'Followers', // Display the count of followers
                                                  style: TextStyle(color:Colors.grey,fontSize: 12 ),textAlign: TextAlign.center,
                                                ),
                                              ],
                                            );
                                          }
                                      }
                                    },
                                  )

                                ),
                                Expanded(
                                  child:FutureBuilder<List<String>>(
                                    future: controller.getFollowing(widget.userId),
                                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return Text('Press button to start.');
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return Text('Awaiting result...');
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else {
                                            // Use the snapshot.data to get the list of followers
                                            List<String> followers = snapshot.data ?? [];

                                            return Column(
                                              children: [
                                                Text(
                                                  ' ${followers.length}', // Display the count of followers
                                                  style:  const TextStyle(color:Colors.black,fontSize: 17),textAlign: TextAlign.center,
                                                ),const Text(
                                                  'Followers', // Display the count of followers
                                                  style: TextStyle(color:Colors.grey,fontSize: 12 ),textAlign: TextAlign.center,
                                                ),
                                              ],
                                            );
                                          }
                                      }
                                    },
                                  )

                                ),
                              ],
                            ),
                            const SizedBox(height: 60),
                            if (widget.otherUserProfile)
                              const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
              forceElevated: innerBoxIsScrolled,
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 14,
                ),
                indicatorColor: Color(0xffAC83F6),
                padding: EdgeInsets.symmetric(horizontal: 40),
                indicatorWeight: 3,
                tabs: [
                  Tab(text: 'Post'),
                  Tab(text: 'Media'),
                  Tab(text: 'Like'),
                ],
              ),
            ),
          ],
          body: SizedBox(
            height: 175 * controller.userProfile.value.posts.length.toDouble(),
            child: TabBarView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: createPostController.postsList.length,
                  itemBuilder: (context, index) {
                    var post = createPostController.postsList[index];
                    if (post != null &&
                        post.userId == widget.userId) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(

                                  child: ProfilePicWidget(widget.profileImage,
                                    45,
                                    45,
                                    picType: 'network',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.username.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      post.timestamp.toString(),
                                      style:
                                      const TextStyle(color: Colors.grey, fontSize: 11),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,

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
                                          ? NetworkImage(post.userPostImage)
                                      as ImageProvider<Object>
                                          : AssetImage('assets/profilepic.png')
                                      as ImageProvider<Object>,
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
                                          builder: (BuildContext context) =>
                                              MyBottomSheet(),
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
                                    child: SvgPicture.asset(
                                      'assets/save_blue.svg',
                                      height: 20,
                                      width: 20,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              post.description,
                              style: const TextStyle(fontSize: 13.0),
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              '#hashtag ',
                              style:
                              const TextStyle(color: Color(0xff7F7F7F), fontSize: 13),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: null);
                    }
                  },
                ),
                GridView.builder(
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
                ),
                PostFeedScreen(
                  saved_posts_Screen: false,
                  ispersonalpost: !widget.otherUserProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
