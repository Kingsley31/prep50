import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/answer_card.dart';
import 'package:prep50/widgets/app_back_icon.dart';

class AnswerWidget extends StatelessWidget {
  // const AnswerWidget({Key key, @required this.title}) : super(key: key);
  // final String title;
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
                      AppText.heading6S("CBT Exam Answers"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      // child: AnswerCard(
                      //   index: index + 1,
                      // ),
                    );
                  })),
        ],
      ),
    );
  }
}
