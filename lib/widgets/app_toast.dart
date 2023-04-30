

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/color.dart';
import '../utils/text.dart';

class AppToast {
  FToast fToast = FToast();

  AppToast({required BuildContext context}){
    fToast.init(context);
  }


  showToast({String message="Error occurred"}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: kPrimaryColor,
      ),
      child:AppText.captionTextM(message,multiText: true,color: Colors.white,),
    );

    //Show the toast message
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 4),
    );
  }

  showReportSuccessToast() {
    Widget toast = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            child: Image.asset("assets/png/success_icon.png"),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.heading6M("Report Sent Successfully"),
                SizedBox(height: 5,),
                AppText.captionTextS("Your reports have been sent successfully, kindly await our reviews and verdict",multiText: true,),
              ],
            ),
          ),
        ],
      ),
    );

    //Show the toast message
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 10),
    );
  }




}