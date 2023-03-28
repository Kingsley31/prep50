import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 137,
      width: double.infinity,
      color: Color(0xffffffff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AppText.heading6(
              "12th June 2021",
              color: kMidGreyColor,
            ),
          ),
          Divider(),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications_active_rounded,
                  color: Color(0xff212121),
                  size: 25,
                ),
                SizedBox(width: 10.14),
                Expanded(
                  // padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.heading6S("Downtime alert"),
                      SizedBox(height: 8),
                      AppText.textField(
                        "We are sorry for the inconveniencies you are "
                        "expereiencing due to the downtime we are having on the"
                        " app, we pledge to resolve this as soon as we can. ",
                        multiText: true,
                        color: Color(0xff666666),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
