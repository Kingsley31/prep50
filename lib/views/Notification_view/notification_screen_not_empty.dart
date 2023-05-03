import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/Notification_view/components/notification_card.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class NotificationScreenNotEmpty extends StatelessWidget {
  // const AlertScreen2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Column(
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
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: 10,
              itemBuilder: (context, index) =>
                  index == 9 ? notMore() : Container(),//NotificationCard(),
            ),
          ),
          // SizedBox(height: 20),
          // SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget notMore() {
    return Container(
      padding: EdgeInsets.all(20),
      height: 100,
      alignment: Alignment.topCenter,
      width: double.infinity,
      color: Color(0xffffffff),
      child: AppText.captionText("No more alerts to show"),
    );
  }
}
