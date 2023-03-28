import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/podcast_view/ptopic_widget.dart';
import 'package:prep50/widgets/app_text_field.dart';

class PodcastTopicScreen extends StatelessWidget {
  // const TopicScreen(
  //     {Key key,})
  //     : super(key: key);
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
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xffffffff),
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      AppText.heading6S("Choose a topic")
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 59,
            width: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.5),
                  child: Row(
                    children: [AppTextField(hText: "Search topic",showPrefixIcon: true,)],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: PodcastTopicWidget())
        ],
      ),
    );
  }
}
