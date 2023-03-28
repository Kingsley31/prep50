import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/views/cbt_view/quiz_view/leaderboard_screen.dart';
import 'package:prep50/widgets/answer_widget.dart';
import 'package:prep50/widgets/app_back_icon.dart';
import 'package:prep50/widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  // const ResultScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              bottom: false,
              child: Row(
                children: [
                  AppBackIcon(),
                  SizedBox(
                    width: 72,
                  ),
                  AppText.heading6("Your Weekly Quiz Result"),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  height: 23,
                  width: 23,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/png/hot_emoji.png"))),
                ),
                SizedBox(
                  width: 24,
                ),
                AppText.captionText(
                  "You Answered 299 Questions Correctly",
                  color: kAccentColor[400],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  height: 23,
                  width: 23,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/png/confused_emoji.png"))),
                ),
                SizedBox(
                  width: 24,
                ),
                AppText.captionText(
                  "Total Number Of guesses is 20",
                  color: kAccentColor[400],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  height: 23,
                  width: 23,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                              AssetImage("assets/png/celebration_emoji.png"))),
                ),
                SizedBox(
                  width: 24,
                ),
                AppText.captionTextS(
                  "Total Score = 120",
                  color: kPrimaryColor,
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/png/medal.png"))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 68,
              width: 280,
              child: Column(
                children: [
                  AppText.textField(
                    "You are Ranked as the first paticipant with the highest overall score of 120%",
                    multiText: true,
                    centered: true,
                    color: kAccentColor[400],
                  ),
                  AppText.captionTextM(
                    "You did it and we are so proud of you",
                    color: kAccentColor[400],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              height: 110,
              width: 340,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("assets/png/abeg_icon.png"))),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LeaderboardScreen())),
                      child: AppText.heading6S(
                        "View Leaderboard",
                        color: kPrimaryColor,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      color: kPrimaryColor,
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 46),
            Row(
              children: [
                Expanded(
                    child: AppButton(
                  title: "Go Home",
                  width: 101,
                  color: false,
                )),
                Expanded(
                    child: AppButton(
                  title: "Show Aswers",
                  width: 197,
                  color: true,
                  onTap: () =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AnswerWidget(),
                  )),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
