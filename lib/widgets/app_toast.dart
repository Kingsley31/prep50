

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
    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 4),
    );
  }




}