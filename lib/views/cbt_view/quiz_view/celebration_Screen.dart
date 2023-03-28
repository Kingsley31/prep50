import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/quiz_view/result_screen.dart';
import 'package:prep50/widgets/app_button.dart';

class CelebrationScreen extends StatelessWidget {
// const CelebrationScreen ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 169.8),
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  // height: 100,
                  // color: Colors.red,
                  child: Image.asset(
                    "assets/image/celebration_left.png",
                    // height: 100,
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/image/medal_check.png",
                    // height: 100,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 48),
          Center(
            child: AppText.heading6S(
              "Quiz Completed",
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: 8),
          Stack(
            fit: StackFit.loose,
            children: [
              Positioned(
                top: 0,
                right: 10,
                child: Container(
                  child: Image.asset(
                    "assets/image/celebration_right.png",
                    fit: BoxFit.cover,
                    // height: 100,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 208,
                  width: 301,
                  child: Column(
                    children: [
                      AppText.textField(
                        "Yah!!! Steve, you just completed the "
                        "weekly quiz,and you stand the chance of "
                        "winning 3000 naira with a 2gb prize.",
                        multiText: true,
                        centered: true,
                      ),
                      SizedBox(height: 3),
                      AppText.textField("Keep it going. We love to see it"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              title: "View Result",
              // width: 343,
              color: true,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ResultScreen())),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
