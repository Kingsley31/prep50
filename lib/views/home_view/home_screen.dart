import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/Notification_view/notification_screen_not_empty.dart';
import 'package:prep50/widgets/app_text_field.dart';

import 'components/drawer.dart';
import 'components/feed.dart';
// import 'package:prep50/views/quiz_view/components/countdown_box.dart';
// import 'package:prep50/views/quiz_view/quiz_screen2.dart';
// import 'package:prep50/views/quiz_view/components/time_box.dart';
// import 'package:prep50/widgets/question_box.dart';
// import 'package:prep50/widgets/app_button.dart';
// import 'package:prep50/views/quiz_view/components/selection_button.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen ({ Key? key }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: AppDrawer(),
      backgroundColor: kAccentColor[300],
      body: Column(
        // padding: EdgeInsets.all(0),
        // shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              left: false,
              right: false,
              // top: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            "assets/image/img1.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      AppText.captionText(
                        "👋Hello, excited to \nsee you Sonofigma",
                        multiText: true,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    NotificationScreenNotEmpty())),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.access_time_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          hText: "Search news, school handles ",
                          showPrefixIcon: true,
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () => showFilterDialog(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 40,
                          width: 40,
                          child: Icon(
                            PrepsIcons.menu,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  )
                  // TextField()
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemCount: 20,
              itemBuilder: (context, index) => FeedWidget(),
            ),
          ),
        ],
      ),
    );
  }

  showFilterDialog(context) {
    List<String> options = ["Trending news", "Newest News", "Oldest News"];
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20),
            height: 240,
            margin: EdgeInsets.all(20),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.heading6("Filter News"),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box,
                              color: kPrimaryColor,
                              size: 40,
                            ),
                            AppText.captionText(options[index]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
