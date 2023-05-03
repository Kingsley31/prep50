import 'package:flutter/material.dart';
import 'package:prep50/models/notification_list_item.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationListItem notificationListItem;
  const NotificationCard({Key? key,required this.notificationListItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificatioDate = DateTime.parse(notificationListItem.createdAt);
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
              "${ DateFormat("dd MMMM y").format(notificatioDate)}",
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
                      AppText.heading6S("${notificationListItem.title}"),
                      SizedBox(height: 8),
                      AppText.textField(
                        "${notificationListItem.body}",
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
