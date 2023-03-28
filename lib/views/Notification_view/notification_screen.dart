import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/Notification_view/components/alert_box.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class NotificationScreen extends StatelessWidget {
  // const AlertScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 92,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [
                      AppBackIcon(),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Notification Alert")
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 51),
            child: Container(
              height: 235,
              width: double.infinity,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 113,
                    backgroundColor: Color(0xfffff4f0),
                  ),
                  Positioned(top: 25.23, left: 54.24, child: AlertBox()),
                  Positioned(top: 93.03, left: 31.64, child: AlertBox()),
                  Positioned(top: 161.03, left: 87.64, child: AlertBox()),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 62, vertical: 32),
              child: AppText.textField(
                "We wouldnotify you once there is an alert we want you to be aware of",
                multiText: true,
                centered: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
