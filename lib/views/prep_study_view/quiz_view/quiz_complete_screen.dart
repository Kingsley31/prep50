import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_button.dart';

class QuizCompleteScreen extends StatelessWidget {
// const QuizCompleteScreen ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 169.8),
          Stack(
            children: [
              Container(
                height: 148,
                width: 148,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfffff4f0),
                ),
              ),
              Positioned(
                top: 14.8,
                left: 14.8,
                child: Container(
                  height: 118.4,
                  width: 118.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFFE8E0),
                  ),
                ),
              ),
              Positioned(
                left: 29.6,
                top: 29.6,
                child: Container(
                  height: 88.8,
                  width: 88.8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/png/success.png"))),
                ),
              )
            ],
          ),
          SizedBox(height: 48),
          AppText.heading6S(
            "Quiz Completed",
            color: kPrimaryColor,
          ),
          SizedBox(height: 8),
          Container(
            height: 88,
            width: 301,
            child: Column(
              children: [
                AppText.textField(
                  "yoo!!! Steve, you just completed the "
                  "quick quiz. From your answers so far your understanding over the"
                  " topic 'concept of government' was really outstanding,Keep it going. We love tosee it",
                  multiText: true,
                  centered: true,
                ),
                SizedBox(height: 3),
                AppText.textField("Keep it going. We love to see it"),
              ],
            ),
          ),
          SizedBox(height: 210),
          AppButton(
            title: "View Result",
            width: 343,
            color: true,
          ),
        ],
      ),
    );
  }
}
