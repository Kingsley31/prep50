

import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/text.dart';

class AppDialog{


  static Future<void> showAppErrorDialog(context,message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText.heading6('Error',color: kPrimaryColor,),
          content:  AppText.textField(message,
            color: kMidBlackColor,
            multiText: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}