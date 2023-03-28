import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/preps_icons_icons.dart';
import 'package:prep50/utils/text.dart';

import '../home_report_page.dart';

class FeedWidget extends StatelessWidget {
  FeedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.heading6("Unillorin State University"),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: kMidGreyColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      AppText.captionText(
                        "3 days ago",
                        color: kMidGreyColor,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              PopupMenuButton(
                child: Icon(Icons.more_horiz),
                onSelected: (dynamic value) {
                  if (value == "Report") showReportDialog(context);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "Report",
                    child: Text('Report'),
                  ),
                  const PopupMenuItem(
                    value: "Copy Url",
                    child: Text('Copy Url'),
                  ),
                ],
              )
            ],
          ),
          AppText.textField(
            "When it came near enough he perceived that it was not grass; there were no blades, but only purple roots. The roots were revolving, for each small plant in the whole patch, like the spokes of a rimless wheel.😇😇",
            multiText: true,
            color: kMidBlackColor,
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 343 / 248,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/image/img3.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              bottomIcon(PrepsIcons.like, selected: true),
              SizedBox(width: 20),
              bottomIcon(PrepsIcons.chat),
              SizedBox(width: 20),
              bottomIcon(Icons.insert_link_rounded),
              Spacer(),
              bottomIcon(Icons.bookmark_outline),
            ],
          )
        ],
      ),
    );
  }

  Widget bottomIcon(IconData icon, {bool selected: false}) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? kPrimaryColor.shade300 : kLighterGreyShadeColour,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 36,
      width: 36,
      child: Icon(
        icon,
        color: selected ? kPrimaryColor : kBlackColor,
      ),
    );
  }

  final List<String> reports = [
    "Nudity",
    "Violence",
    "False Information",
    "Hate Speech",
    "Gross Content",
    "Spam",
    "Harassment"
  ];

  showReportDialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(20),
          height: 400,
          margin: EdgeInsets.all(20),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.heading6("Please, kindly select a problem"),
                AppText.textField(
                  "Be very assured that all attentions would be provided and attended to your report",
                  multiText: true,
                  color: kMidGreyColor,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomeReportScreen(
                              title: reports[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: AppText.heading6(reports[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
