import 'package:flutter/material.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/Notification_view/components/alert_box.dart';
import 'package:prep50/views/Notification_view/components/notification_card.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_toast.dart';
import 'package:provider/provider.dart';

import '../../view-models/notifications_screen_viewmodel.dart';
import '../../widgets/app_button.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  AppToast? _appToast;


  @override
  void initState() {
    super.initState();
    _appToast=AppToast(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotificationsScreenViewModel notificationsScreenViewModel = Provider.of<NotificationsScreenViewModel>(context,listen:false);
      notificationsScreenViewModel.loadNotifications();
    });
  }

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
          Expanded(
              child: Consumer<NotificationsScreenViewModel>(
                builder: (context,notificationScreenViewModel,child){
                  return notificationScreenViewModel.errorMessage.isNotEmpty?
                      _buildErrorWidget(notificationScreenViewModel):
                      notificationScreenViewModel.isLoadingNotifications?
                          _buildLoadingWidget():
                      notificationScreenViewModel.notificationList.isEmpty?
                              _buildEmptyScreen():
                              _buildNotificationList(notificationScreenViewModel);
                },
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(NotificationsScreenViewModel notificationsScreenViewModel) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appToast?.showToast(message: notificationsScreenViewModel.errorMessage);
    });

    print(notificationsScreenViewModel.errorMessage);
    return Center(
      child: AppButton(
        title: "Load Notifications",
        width: 197,
        color: true,
        onTap: () => {
          notificationsScreenViewModel.loadNotifications()
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }


  Widget _buildEmptyScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              "We would notify you once there is an alert we want you to be aware of",
              multiText: true,
              centered: true,
            ),
          ),
        )
      ],
    );
 }

 Widget _buildNotificationList(NotificationsScreenViewModel notificationScreenViewModel) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: notificationScreenViewModel.notificationList.length,
      itemBuilder: (context, index) =>
      index == (notificationScreenViewModel.notificationList.length-1) ? notMore() : NotificationCard(notificationListItem: notificationScreenViewModel.notificationList[index],),
    );
 }

  Widget notMore() {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      width: double.infinity,
      color: Color(0xffffffff),
      child: AppText.captionText("No more alerts to show"),
    );
  }
}
