import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../Controllers/GetuserdataDataController.dart';
import '../../../../Controllers/Profile_Edit_Controller.dart';
class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}
class _ProfileEditState extends State<ProfileEdit> {
final ProfileEditController profileEditController =Get.put(ProfileEditController(),tag: "profileEditController");
  GetUserDataController getUserDataController = Get.put(GetUserDataController());
@override
void initState() {
  super.initState();
  // Set the initial values from profileEditController
  if (profileEditController.nameController.text.isEmpty) {
    profileEditController.nameController.text =
        profileEditController.getUserDataController.getUserDataRxModel.value!.name;
  }
  if (profileEditController.dOBController.text.isEmpty) {
    profileEditController.dOBController.text =
        profileEditController.getUserDataController.getUserDataRxModel.value!.dob;
  }
  if (profileEditController.bioController.text.isEmpty) {
    profileEditController.bioController.text =
        profileEditController.getUserDataController.getUserDataRxModel.value!.bio.toString();
  }
  if (profileEditController.locationController.text.isEmpty) {
    profileEditController.locationController.text =
        profileEditController. getUserDataController.getUserDataRxModel.value!.location.toString();
  }
}
  @override
  Widget build(BuildContext context) {
  return Obx(() =>  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // First Image
                profileEditController.selectedCoverImage?.value != null ?  Container(
                  height: 170,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(profileEditController.selectedCoverImage?.value ?? File('path/to/default/image')),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          height: 25,
                          width: 75,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: TextButton(onPressed: () {
                            profileEditController.coverPickedImage();


                          }, child: const Text(
                            "Edit Cover", style: TextStyle(
                              color: Colors.white, fontSize: 8),),)),
                    ),
                  ),
                ):Container(
                  height: 170,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(getUserDataController.getUserDataRxModel.value!.backgroundImage,),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          height: 25,
                          width: 75,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: TextButton(onPressed: () {
                            profileEditController.coverPickedImage();


                          }, child: const Text(
                            "Edit Cover", style: TextStyle(
                              color: Colors.white, fontSize: 8),),)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.16,
                    left: 20,
                  ),
                  child:Container(
                    height: 95,
                    width: 95,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Stack(
                      children: [
                        profileEditController.selectedProfileImage?.value != null ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xffAC83F6)),
                              image: DecorationImage( image:
                              FileImage(profileEditController.selectedProfileImage?.value ?? File('path/to/default/image'),),fit: BoxFit.cover
                                  )
                          ),
                          // child: Icon(
                          //   Icons.camera_alt,
                          //   size: 40,
                          //   color: const Color(0xffAC83F6),
                          // ),
                        ): Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xffAC83F6)),
                        image: DecorationImage( image: NetworkImage(getUserDataController.getUserDataRxModel.value!.profileimage,), fit: BoxFit.cover),
                        )
                    ),
                    // child: Icon(
                    //   Icons.camera_alt,
                    //   size: 40,
                    //   color: const Color(0xffAC83F6),
                    // ),

                        InkWell(onTap: () {
                          profileEditController.profilePickedImage();
                        },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xffAC83F6)),
                              ),
                              child: Center(
                                child: InkWell(onTap: () {
                                  profileEditController.profilePickedImage();
                                },
                                    child: SvgPicture.asset("assets/Edit.svg")),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2),
                      ],
                    ),
                    child: TextField(
                      controller: profileEditController.nameController,

                      decoration: InputDecoration(
                        hintText: 'Minha Anjum',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        prefixIcon: Transform.scale(
                          scale: 0.4,
                          child: SvgPicture.asset(
                            'assets/Iconly-Bulk-Profile.svg',
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
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
                    height: Get.height * 0.02,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2),
                      ],
                    ),
                    child: TextField(
                      readOnly: true,onTap: () {
                      profileEditController.selectDOB(context);
                    },
                      controller: profileEditController.dOBController,
                      decoration: InputDecoration(
                        hintText: 'dd MMM yyyy',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        contentPadding: const EdgeInsets.all(8),
                        prefixIcon: Transform.scale(
                          scale: 0.4,
                          child: SvgPicture.asset(
                            'assets/Iconly-Bold-Calendar.svg',
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2),
                      ],
                    ),
                    child: TextField(
                      controller:profileEditController.locationController,
                      decoration: InputDecoration(
                        hintText: 'Add Location',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        contentPadding: const EdgeInsets.all(8),
                        prefixIcon: Transform.scale(
                          scale: 0.4,
                          child: SvgPicture.asset(
                            'assets/Location.svg',
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
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
                    height: Get.height * 0.02,
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2)
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: profileEditController.bioController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Add bio',
                          hintStyle: const TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.all(8),
                          prefixIcon: Transform.scale(
                            scale: 0.4,
                            child: SvgPicture.asset(
                              'assets/id-icon.svg',
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  TextButton(
                    onPressed: () {
                      profileEditController.updateProfileHandler(
                        userName: profileEditController.nameController.text,
                        userBio: profileEditController.bioController.text,
                        userDOB: profileEditController.dOBController.text,
                        userLocation: profileEditController.locationController.text,
                      );

                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.6,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.5,
                          ),
                        ],
                        color: Color(0xffAC83F6),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.6,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(15)),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style:
                          TextStyle(color: Color(0xffAC83F6), fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}


