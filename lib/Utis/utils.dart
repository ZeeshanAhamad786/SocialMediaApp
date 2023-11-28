import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socialmediaapp/Utis/colors.dart';
class Utils {

  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: ColorValues.blackColor ,
      textColor: ColorValues.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,


    );
  }


  static toastMessageCenter(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: ColorValues.blackColor ,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: ColorValues.whiteColor,
    );
  }

  static snackBar(String title, String message){
    Get.snackbar(
        title,
        message ,
        backgroundColor: ColorValues.successColor,
        colorText: ColorValues.whiteColor
    );
  }
  static Future<void> startLoading({required String loadingStatus}) async {
    await EasyLoading.show(
      status: loadingStatus,
      maskType: EasyLoadingMaskType.black,
    );

    await Future.delayed(Duration(seconds: 2));

    await EasyLoading.dismiss();
  }
}