import 'package:flutter/material.dart';
import 'package:prep50/utils/color.dart';
import 'package:prep50/utils/text.dart';
import 'package:prep50/widgets/app_button.dart';

class QUizResultScreen extends StatelessWidget {
  // const QuizResultScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_outlined,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 72,
                ),
                AppText.heading6("Your Quiz Result"),
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
                          image: AssetImage("assets/png/hot_emoji.png"))),
                ),
                SizedBox(
                  width: 24,
                ),
                AppText.captionText(
                  "You Answered 40 Questions Correctly",
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
                  "Total topic score 15%",
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
              height: 48,
              width: 280,
              child: Column(
                children: [
                  AppText.textField(
                    "Keep Going, keep studying and we are  so certain you would ace you next exam",
                    multiText: true,
                    centered: true,
                    color: kAccentColor[400],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              height: 108,
              width: 340,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("assets/png/abeg_icon.png"))),
            ),
            SizedBox(height: 96),
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
                        title: "Show Aswers", width: 197, color: true)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
