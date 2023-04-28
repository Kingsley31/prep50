import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/quiz_view/components/countdown_box.dart';
import 'package:prep50/widgets/answer_widget.dart';
import 'package:prep50/widgets/app_button.dart';
import 'package:prep50/widgets/question_widget.dart';

import '../cbt_screen.dart';

class QuizScreen extends StatelessWidget {
  // const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 69,
          left: 23,
          right: 23,
        ),
        child: ListView(
          children: [
            Center(child: AppText.heading2("Weekly Quiz")),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.all(20),
              // height: 83,
              width: double.infinity,
              color: kLighterGreyShadeColour,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.heading6S(
                    "🎯 Giveaway 🎯:",
                    color: kPrimaryColor,
                  ),
                  AppText.heading6M(
                    "The first 3 users with the highest"
                    "score gets",
                    centered: true,
                    color: kMidBlackColor,
                    multiText: true,
                  ),
                  AppText.heading6M(
                    "N3000 with a 2gb data",
                    centered: true,
                    multiText: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 254,
              width: 254,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("assets/png/quiz_countdown.png"))),
            ),
            SizedBox(height: 30),
            Center(child: AppText.heading2S("Starting in")),
            SizedBox(height: 25),
            //CountdownBox(),
            SizedBox(height: 15),
            Center(
                child: AppButton(
              title: "Join Quiz",
              width: 196,
              color: true,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuestionWidget(),
                ),
              ),
            )),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
