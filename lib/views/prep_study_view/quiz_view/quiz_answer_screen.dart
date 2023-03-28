import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/answer_card.dart';

class QuizAnswerScreen extends StatelessWidget {
  // const QuizAnswerScreen({Key key, @required this.title}) : super(key: key);
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
                      AppText.heading6S("Quiz Answers"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(child: AnswerCard()),
        ],
      ),
    );
  }
}
