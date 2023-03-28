import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/prep_study_view/tutorial_view/topic_widget.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class TopicScreen extends StatelessWidget {
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
            // height: 92,
            width: double.infinity,
            color: Color(0xffffffff),
            child: SafeArea(
              bottom: false,
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
                        AppText.heading6S("Choose a topic")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 20,
            itemBuilder: (context, index) => TopicWidget(),
          ))
        ],
      ),
    );
  }
}
